class Adminsbackoffice::TopicsController < ApplicationController
  before_action :set_subject, only: [ :create ]
  before_action :set_topic, only: [ :update, :destroy ]
  def index
    @topics = Topic.includes(:subject).all
    render json: @topics
  end

  def create
    @topic = @subject.topics.build(topic_params)
    if @topic.save
      render json: @topic, status: :created
    else
      render json: { errors: @topic.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @topic.update(topic_params)
      render json: @topic
    else
      render json: { errors: @topic.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @topic.destroy
    head :no_content
  end

  private

  def topic_params
    params.require(:topic).permit(:name)
  end

  def set_subject
    @subject = Subject.find(params[:subject_id])
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end
end
