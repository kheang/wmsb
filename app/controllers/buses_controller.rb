class BusesController < ApplicationController
  self.responder = BusesResponder
  respond_to :html, :json, only: :index
  before_filter :authenticate!
  helper_method :serialized_assignments

  def index
    respond_with(assignments)
  end

  private

  def search
    @search ||= AssignmentSearch.find(session[:contact_id])
  end

  def assignments
    @assignments ||= search.assignments
  end

  def serialized_assignments
    ActiveModel::ArraySerializer.new(assignments.with_gps_data)
  end

  def authenticate!
    if session_exists? && session_expired?
      cookies.delete(:current_assignment)
      session.delete(:contact_id)

      respond_to do |format|
        format.html { redirect_to :root, alert: 'Your session has expired.' }
        format.json { head 401 }
      end
    elsif !session[:contact_id]
      respond_to do |format|
        format.html { redirect_to :root, alert: 'You need to sign in first.' }
        format.json { head 401 }
      end
    end
  end

  def interpolation_options
    { names: assignments.without_gps_data.map(&:student_name).join(', ') }
  end
end
