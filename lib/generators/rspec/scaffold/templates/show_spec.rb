require 'spec_helper'

<% output_attributes = attributes.reject{|attribute| [:datetime, :timestamp, :time, :date].index(attribute.type) } -%>
describe "<%= ns_table_name %>/show" do
  before(:each) do
    @<%= ns_file_name %> = assign(:<%= ns_file_name %>, stub_model(<%= class_name %><%= output_attributes.empty? ? '))' : ',' %>
<% output_attributes.each_with_index do |attribute, attribute_index| -%>
      :<%= attribute.name %> => <%= value_for(attribute) %><%= attribute_index == output_attributes.length - 1 ? '' : ','%>
<% end -%>
<% if !output_attributes.empty? -%>
    ))
<% end -%>
  end

  it "renders attributes in <p>" do
    render
<% unless webrat? -%>
    # Run the generator again with the --webrat flag if you want to use webrat matchers
<% end -%>
<% for attribute in output_attributes -%>
<% if webrat? -%>
    expect(rendered).to contain(<%= value_for(attribute) %>.to_s)
<% else -%>
    expect(rendered).to match(/<%= eval(value_for(attribute)) %>/)
<% end -%>
<% end -%>
  end
end
