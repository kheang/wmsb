class AssignmentCollection
  include Enumerable

  attr_reader :assignments, :errors

  delegate :each, to: :assignments

  def initialize(collection, trip_flag)
    @assignments = collection.map { |assignment| BusAssignment.new(assignment, trip_flag) }
  end

  def with_gps_data
    @with_gps_data ||= select(&:gps_available?)
  end

  def without_gps_data
    @without_gps_data ||= reject(&:gps_available?)
  end

  protected

  def respond_to_missing?(name, include_private = false)
    super || assignments.respond_to?(name, include_private)
  end

  def method_missing(name, *args, &block)
    if assignments.respond_to?(name)
      self.class.delegate name, to: :assignments
      assignments.send(name, *args, &block)
    else
      super
    end
  end
end
