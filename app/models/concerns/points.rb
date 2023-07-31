module Points
  extend ActiveSupport::Concern

  POINT_MAP = {
    "1": 5,
    "2": 4,
    "3": 3,
    "4": 2,
    "5": 1
  }

  def update_entry_total_points
    points = self.votes.pluck(:position).map do |position|
      POINT_MAP[position.to_s.to_sym]
    end.compact.sum

    update(total_points: points)
  end
end
