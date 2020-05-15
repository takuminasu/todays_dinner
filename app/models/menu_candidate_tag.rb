class MenuCandidateTag < ApplicationRecord
  def self.make(tag_candidates)
    MenuCandidateTag.where.not(tag_id: tag_candidates).destroy_all
    tag_candidates.each do |menu_candidate_tag|
      tag_id = menu_candidate_tag.to_i
      MenuCandidateTag.create(tag_id: tag_id) unless MenuCandidateTag.where(tag_id: tag_id).exists?
    end
  end
end
