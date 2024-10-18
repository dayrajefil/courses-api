FactoryBot.define do
  factory :course do
    title { "My Course" }
    description { "Course Description" }
    start_date { Date.today }
    end_date { Date.today + 90.days }
  end
end
