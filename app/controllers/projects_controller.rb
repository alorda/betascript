class ProjectsController < ApplicationController
  def index
    @projects = if params[:search]
      Project.where("LOWER(title) LIKE LOWER(?)", "%#{params[:search]}%")
    else
      Project.all
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if @project.update_attributes(project_params)
      redirect_to project_path(@project)
    else
      render :edit
    end

  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save
      redirect_to projects_path, notice: "Your project was created successfully!"
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])

    if current_user
      @comment = Comment.new
    end

  end

  private
  def project_params
    params.require(:project).permit(:title, :description, :story, :genre, tags_attributes: [:title])
  end

end
