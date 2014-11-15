class Problem < ActiveRecord::Base
  mount_uploader :solution, ProblemSolutionUploader
  mount_uploader :input, ProblemInputUploader

end
