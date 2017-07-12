class Eligibilities::InFms
  def eligible?(user)
    (user.fms_accepted? || user.fms_status == 'fms_pending') && not_admin?(user)
  end

  def label
    'FMS Vendors'
  end

  private

  def not_admin?(user)
    !Admins.verify?(user.github_id)
  end
end
