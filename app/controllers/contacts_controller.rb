class ContactsController < ApplicationController
  def create
    company = Company.find(params[:company_id])
    company.contacts.create(contact_params)
    redirect_to company_path(company)
  end

  def destroy
    contact = Contact.find(params[:id])
    if contact.destroy
      flash[:success] = "#{contact.name} has been deleted"
      redirect_to company_path(params[:company_id])
    else
      flash[:failure] = "#{contact.name} could not be deleted"
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
      flash[:sucess] = "#{contact.name} was sucessfully updated"
      redirect_to company_path(company)
    else
      flash[:failure] = "#{contact.name} was not updated"
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :role, :email)
  end
end
