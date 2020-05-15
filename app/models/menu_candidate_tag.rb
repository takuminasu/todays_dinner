class MenuCandidateTag < ApplicationRecord
  def self.make(tag_candidates)
    MenuCandidateTag.destroy_all
    tag_candidates.each do |menu_candidate_tag|
      MenuCandidateTag.create(tag_id: menu_candidate_tag.to_i)
    end
  end
end
