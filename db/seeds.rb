Admin.create email: 'admin@mail.org', password: 'asdasd', name: 'John Smith'

[
  'Design', 'Project Management', 'Development', 'Frontend'
].each do |name|
  Department.create name: name
end

TicketStatus.create name: 'Waiting for Staff Response', default: true

[ 'Waiting for Customer', 'On Hold', 'Canceled', 'Completed' ].each do |status|
  TicketStatus.create name: status
end
