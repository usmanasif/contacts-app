class ContactsDatatable
  delegate :params, :current_user, :render, to: :@view

  def initialize(view)
    @view = view
  end


  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: current_user.contacts.count,
      iTotalDisplayRecords: contacts.total_entries,
      aaData: data
    }
  end


private
  def data
    contacts.map do |contact|
      [
        contact.first_name,
        contact.last_name,
        contact.email,
        contact.phone,
        contact.company,
        render(partial: 'contacts/contact_groups.html', locals: {contact: contact}),
        render(partial: 'contacts/contact_actions.html', locals: {contact: contact})
      ]
    end
  end


  def contacts
    @contacts ||= fetch_contacts
  end


  def fetch_contacts
    contacts = current_user.contacts.includes(:groups).order("#{sort_column} #{sort_direction}")
    contacts = contacts.page(page).per_page(per_page)

    if params[:sSearch].present?
      like = cols.map {|col| "#{col} LIKE :search"}

      contacts = contacts.where(
        like.join(' OR '),
        search: "%#{params[:sSearch]}%"
      )
    end

    contacts
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    cols[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end

  def cols
    %w[first_name last_name email phone company]
  end
end
