class Eligibilities::MWBE < Eligibilities::InFms
  def eligible?(user)
    super && user.mwbe?
  end

  def label
    'mwbe only'
  end
end
