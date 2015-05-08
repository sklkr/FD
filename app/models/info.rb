class Info < ActiveRecord::Base
  belongs_to :partner
 
  attachment :panproof, extension: 'pdf'
  attachment :idproof, extension: 'pdf'
  attachment :taxproof, extension: 'pdf'
end
