class BirdsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
  def index
    birds = Bird.all
    render json: birds
  end

  def create
    bird = Bird.create!(bird_params)
    render json: bird, status: :created
  end

  def update
    bird = find_bird
    bird.update!(bird_params)
    render json: bird
  end

  private

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end