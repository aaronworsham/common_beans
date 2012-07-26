class BackboneController < ApplicationController
  respond_to :json
  def create
    if params[:model_name]
      obj = Object.const_get(params[:model_name])
      if obj and obj.resource?
        model = obj.create(params[:backbone].reject{|x| x == 'model_name'}.merge!(:user_id => current_user.id))
        if model.valid?
          respond_with do |f|
            f.json{render :json => model.attributes.to_json}
          end
        else
          respond_with do |f|
            f.json{render :json => ({:errors => model.errors.full_messages}.to_json)}
          end
        end
      end
    end
  end
  def show
    if params[:model_name]
      obj = Object.const_get(params[:model_name])
      if obj and obj.resource?
        data = obj.find_by_id_and_user_as_json(params[:id], current_user)
        if data.present?
          respond_with do |f|
            f.json{render :json => data.to_json}
          end
        else
          respond_with do |f|
            f.json{render :json => ({:errors => 'Could not locate Data'}.to_json)}
          end
        end
      else
        respond_with do |f|
          f.json{render :json => ({:errors => 'Could not locate Object'}.to_json)}
        end
      end
    end
  end
  def destroy
    if params[:model_name]
      obj = Object.const_get(params[:model_name])
      if obj and obj.resource?
        data = obj.find_by_id_and_user(params[:id], current_user)
        if data.present?
          if data.destroy
            respond_with do |f|
              f.json{render :json => data.to_json}
            end
          else
            respond_with do |f|
              f.json{render :json => ({:errors => 'Could not Destroy Data'}.to_json)}
            end
          end
        else
          respond_with do |f|
            f.json{render :json => ({:errors => 'Could not Locate Data'}.to_json)}
          end
        end
      else
        respond_with do |f|
          f.json{render :json => ({:errors => 'Could not locate Object'}.to_json)}
        end
      end
    end
  end
 
end
