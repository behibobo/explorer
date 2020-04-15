class App::LoplobsController < AppController
    def index
        lops = Loplob.all
        render json:  lops.to_json
    end


    def get_loplobs
        lop = Loplob.where(required_credit: params[:required_credit]).first

        if lop.nil?
            render json: [].to_json
            return
        end

        UserLoplob.where(user:current_user).destroy_all
        lop.qty.times do
            UserLoplob.create(
                uuid: SecureRandom.uuid(),
                value: 0,
                user: current_user
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


    def purchase
        lop = UserLoplob.find_by(uuid: params[:uuid])
        
        success = false
        message = ""

        if current_user.credit < params[:required_credit].to_i
            message = "insufficient credit"
            render json: {success: success, message: message }, status: 422
            return
        end
        
        current_user.credit -= params[:required_credit]
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
        UserLoplob.where(user:current_user).destroy_all
        render json: {success: success, message: message, value: lop.value }
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
  