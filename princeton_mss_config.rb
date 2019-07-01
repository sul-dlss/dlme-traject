# frozen_string_literal: true

require 'traject_plus'
require 'dlme_json_resource_writer'
require 'macros/dlme'
extend Macros::DLME
extend TrajectPlus::Macros
extend TrajectPlus::Macros::JSON

settings do
  provide 'writer_class_name', 'DlmeJsonResourceWriter'
  provide 'reader_class_name', 'TrajectPlus::JsonReader'
end

# Cho Required
to_field 'id', extract_json('.identifier'), strip
to_field 'cho_title', extract_json('.title'), strip

# Cho Other
to_field 'cho_alternate', extract_json('.cho_alternate'), strip
to_field 'cho_creator', extract_json('.author'), strip
to_field 'cho_contributor', extract_json('contributor'), strip
to_field 'cho_date', extract_json('.date'), strip
to_field 'cho_dc_rights', literal('https://rbsc.princeton.edu/services/imaging-publication-services')
to_field 'cho_description', extract_json('.description'), strip
to_field 'cho_description', extract_json('.contents'), strip
to_field 'cho_description', extract_json('.binding_note'), strip
to_field 'cho_edm_type', literal('Text')
to_field 'cho_extent', extract_json('.extent'), strip
to_field 'cho_identifier', extract_json('.source_metadata_identifier'), strip
to_field 'cho_identifier', extract_json('.local_identifier'), strip
to_field 'cho_identifier', extract_json('.alternate_identifier'), strip
to_field 'cho_language', extract_json('.language'), strip
to_field 'cho_provenance', extract_json('.provenance'), strip
to_field 'cho_publisher', extract_json('.publisher'), strip
to_field 'cho_subject', extract_json('.subject'), strip
to_field 'cho_type', extract_json('.type')

# Agg
to_field 'agg_data_provider', data_provider
to_field 'agg_provider', provider
to_field 'agg_is_shown_at' do |_record, accumulator, context|
  accumulator << transform_values(
    context,
    'wr_id' => [extract_json('.identifier'), strip]
  )
end
to_field 'agg_preview' do |_record, accumulator, context|
  accumulator << transform_values(
    context,
    'wr_id' => [extract_json('.thumbnail'), strip]
  )
end