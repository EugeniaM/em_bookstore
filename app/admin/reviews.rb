ActiveAdmin.register Review do
  permit_params :status

  scope ("Unprocessed") , :default => true do |scope|
    scope.where(status: 'Unprocessed')
  end
  scope("Approved") { |scope| scope.where(status: "Approved") }
  scope("Rejected") { |scope| scope.where(status: "Rejected") }

  index do
    column :book
    column :created_at
    column :user
    column :status
    column "" do |review|
      link_to 'Approve', "/admin/reviews/approve/#{review.id}"
    end
    column "" do |review|
      link_to 'Reject', "/admin/reviews/reject/#{review.id}"
    end
  end

  controller do
    def approve
      @review = Review.find(params[:id])
      if @review.present?
        @review.update_attribute(:status, 'Approved')
        flash[:notice] = 'Review marked as approved'        
      else
        flash[:error] = 'Could not find review'
      end

      redirect_to admin_reviews_path
    end

    def reject
      @review = Review.find(params[:id])
      if @review.present?
        @review.update_attribute(:status, 'Rejected')
        flash[:notice] = 'Review marked as rejected'        
      else
        flash[:error] = 'Could not find review'
      end

      redirect_to admin_reviews_path
    end
  end
end
