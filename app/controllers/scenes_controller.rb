class ScenesController < ApplicationController

  before_action :load_project

  def new
    @scene = Scene.new
  end

  def create
    @scene = @project.scenes.build(scene_params)
    # @scene.user = current_user

    if @scene.save

      respond_to do |format|
        format.html do
          if request.xhr?
            render @scene
          else
            redirect_to project_path(@project)
          end
        end
        format.js
      end
    else
      render 'project_path(@project)'
    end
  end

  def show
    @scene = Scene.find(params[:id])
  end

private

  def scene_params
    params.require(:scene)
          .permit(:heading, :action,
                  characters_attributes: [:name, :dialogue, :parenthetical, :_destroy])
  end

  def load_project
    @project = Project.find(params[:project_id])
  end
end