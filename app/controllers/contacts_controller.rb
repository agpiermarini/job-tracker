class ContactsController < ApplicationController
  def create
    company = Company.find(params[:company_id])
    contact = company.contacts.create(contact_params)
    flash[:success] = "Created new contact for #{Contact.last.name}"
    redirect_to company_path(company)
  end

  def destroy
    contact = Contact.find(params[:id])
    if contact.destroy
      flash[:success] = "Deleted contact for #{contact.name}"
      redirect_to company_path(params[:company_id])
    else
      flash[:alert] = "Failed to delete contact for #{contact.name}"
    end
  end

  def edit
    @company = Company.find(params[:company_id])
    @contact = Contact.find(params[:id])
    @contacts = @company.contacts
  end

  def update
    contact = Contact.find(params[:id])
    company = Company.find(params[:company_id])
    if contact.update(contact_params)
      flash[:success] = "#{contact.name} was sucessfully updated"
      redirect_to company_path(company)
    else
      flash[:alert] = "#{contact.name} was not updated"
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :role, :email)
  end
end
