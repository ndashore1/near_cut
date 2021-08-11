# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def clear_flash
    flash[:notice] = nil
    flash[:error] = nil
  end
end
