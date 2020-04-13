class App::LoplobsController < AppController
    def index
        lop = Loplob.where(required_credit: params[:required_credit]).first
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

        render json: current_user.user_loplobs.shuffle.to_json
    end
end
  