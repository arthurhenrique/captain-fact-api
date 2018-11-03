import EctoEnum

defenum(
  DB.Type.NotificationType,
  :notification_type,
  [
    :reply_to_comment,
    :new_comment,
    :new_statement,
    :updated_statement,
    :updated_video,
    :new_speaker,
    :updated_speaker,
    :new_achievement,
    :email_confirmed
  ]
)
