class BackboneController < ApplicationController
  respond_to :json
  def create
    if params[:model_name]
      obj = Object.const_get(params[:model_name])
      if obj and obj.resource?
        model = obj.create(params[:backbone].reject{|x| x == 'model_name'})
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
end
