class App::LoplobsController < AppController
    def index
        lops = Loplob.all
        render json:  lops.to_json
    end


    def show
        lop = Loplob.find(params[:id])

        if lop.nil?
            render json: [].to_json
            return
        end

        UserLoplob.where(user:current_user).destroy_all
        lop.qty.times do
            UserLoplob.create(
                uuid: SecureRandom.uuid(),
                value: 0,
                user: current_user,
                required_credit: lop.required_credit
            )
        end

        lop.loplob_values.each do |val|

            ids = current_user
                .user_loplobs
                .where(value: 0)
                .limit(val.qty)
                .shuffle
                .pluck(:id)

            current_user
                .user_loplobs
                .where(id: ids)
                .update(value: val.value)

        end
        render json: current_user.user_loplobs.shuffle
            .to_json
    end


    def create
        lop = UserLoplob.find_by(uuid: params[:uuid])
        success = false
        message = ""

        if current_user.credit < lop.required_credit
            message = "شما اعتبار کارفی برای انجام این عملیات ندارید لطفا کیف پول خود را شارژ کنید"
            success = false
            value = 0
        else
            value = lop.value
            current_user.credit -= lop.required_credit
            current_user.save

            if lop.value == 0
                message = "lost"
                success = false

                PurchasedLoplob.create(
                    uuid: params[:uuid],
                    value: lop.value,
                    date: Time.now,
                    user:current_user
                )
            else
                PurchasedLoplob.create(
                    uuid: params[:uuid],
                    value: lop.value,
                    date: Time.now,
                    user:current_user
                )
                message = "won"
                success = true
            end
        end
        UserLoplob.where(user:current_user).destroy_all
        render json: {success: success, message: message, value: value }
    end


    def purchased_loplobs
        items = []
        loplobs = PurchasedLoplob.where(user: current_user)
            .order(created_at: :desc)
            .limit(params[:limit])
            .offset(params[:offset])

        loplobs.each do |item|
            p = {
                id: item.id,
                uuid: item.uuid,
                value: item.value,
                date: item.date.to_date.to_pdate.to_s,
                won: item.value.to_i > 0 ? true : false
            }
        items.push p
        end
        render json: items.to_json
    end
end
  