defmodule CF.Notifications.NotificationBuilder do
  @moduledoc """
  A module to build Notification from various inputs.
  """

  alias DB.Schema.Subscription
  alias DB.Schema.UserAction
  alias DB.Schema.Notification
  alias DB.Type.NotificationType
  alias DB.Type.SubscriptionReason

  @doc """
  Return `Notification` params to put in a changeset for given action and
  subscription.

  ## Examples

      iex> action = %UserAction{id: 42, type: :create, entity: :comment}
      iex> subscription = %Subscription{user_id: 100, reason: :is_author}
      iex> NotificationBuilder.for_subscribed_action(action, subscription)
      %{action_id: 42, type: :reply_to_comment, user_id: 100}
  """
  @spec for_subscribed_action(UserAction.t(), Subscription.t()) :: Notification.t()
  def for_subscribed_action(action, subscription) when not is_nil(subscription) do
    %{
      user_id: subscription.user_id,
      action_id: action.id,
      type: notification_type(action, subscription)
    }
  end

  @spec notification_type(SubscriptionReason.t(), Subscription.t()) :: NotificationType.t()
  defp notification_type(%{type: :create, entity: :comment}, %{reason: :is_author}),
    do: :reply_to_comment

  defp notification_type(%{type: :create, entity: :comment}, _),
    do: :new_comment

  defp notification_type(%{type: :create, entity: :statement}, _),
    do: :new_statement

  defp notification_type(%{type: :update, entity: :statement}, _),
    do: :updated_statement

  defp notification_type(%{type: :update, entity: :video}, _),
    do: :new_statement
end
