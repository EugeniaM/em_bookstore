ActiveAdmin.register Order do
  permit_params :order_status_id

  scope ("In Progress") , :default => true do |scope|
    scope.where(order_status_id: 1)
  end
  scope("Waiting for processing") { |scope| scope.where(order_status_id: 2) }
  scope("In Deliveru") { |scope| scope.where(order_status_id: 3) }
  scope("Delivered") { |scope| scope.where(order_status_id: 4) }
  scope("Canceled") { |scope| scope.where(order_status_id: 5) }

  index do
    column :id
    column :created_at
    column :order_status
    # column "" do |review|
    #   link_to 'Approve', "/admin/reviews/approve/#{review.id}"
    # end
    # column "" do |review|
    #   link_to 'Reject', "/admin/reviews/reject/#{review.id}"
    # end
    column "" do |resource|
      link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
    end
  end

  form do |f|
    case order.order_status_id
    when 1
      collection = {}
    when 2
      collection = {'In Delivery' => 3, 'Canceled' => 5}
    when 3
      collection = {'Delivered' => 4, 'Canceled' => 5}
    when 4
      collection = {}
    when 5
      collection = {}
    end

    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :order_status, as: :select, collection: collection
    end

    f.actions
  end 
end
