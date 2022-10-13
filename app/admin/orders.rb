# frozen_string_literal: true

ActiveAdmin.register Order do
  actions :index, :show

  scope :in_queue, default: true
  scope :in_delivery
  scope :delivered
  scope :canceled

  index do
    selectable_column
    id_column

    column :number
    column :created_at
    column :state
    actions
  end

  action_item :in_delivery, only: :show, if: proc { resource.in_queue? } do
    link_to t('active_admin.orders.links.in_delivery'), in_delivery_admin_order_path(order), method: :put
  end

  action_item :delivered, only: :show, if: proc { resource.in_delivery? } do
    link_to t('active_admin.orders.links.delivered'), delivered_admin_order_path(order), method: :put
  end

  action_item :canceled, only: :show do
    link_to t('active_admin.orders.links.canceled'), canceled_admin_order_path(order), method: :put
  end

  member_action :canceled, method: :put do
    resource.canceled!
    redirect_to resource_path, notice: I18n.t('active_admin.orders.notice.canceled')
  end

  member_action :delivered, method: :put do
    resource.delivered!
    redirect_to resource_path, notice: I18n.t('active_admin.orders.notice.delivered')
  end

  member_action :in_delivery, method: :put do
    resource.in_delivery!
    redirect_to resource_path, notice: I18n.t('active_admin.orders.notice.in_delivery')
  end

  show do
    attributes_table do
      row :number
      row :created_at
      row :status
    end
  end
end
