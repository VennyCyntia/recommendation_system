import 'dart:convert';

class AttachmentFileDataModel {
  String? attachment_id;
  String? attachment_name;
  int? attachment_size;
  String? attachment_extension;

  AttachmentFileDataModel({
    this.attachment_id,
    this.attachment_name,
    this.attachment_size,
    this.attachment_extension,
});

  AttachmentFileDataModel.fromJson(Map<String, dynamic> json) {
    attachment_id = json['attachment_id'];
    attachment_name = json['attachment_name'];
    attachment_size = json['attachment_size'];
    attachment_extension = json['attachment_extension'];
  }

  Map<String, dynamic> toJson() {
    return {
      'attachment_id': attachment_id,
      'attachment_name': attachment_name,
      'attachment_size': attachment_size,
      'attachment_extension': attachment_extension,
    };
  }

  AttachmentFileDataModel.fromMap(Map<String, dynamic> map) {
    attachment_id = map['attachment_id'];
    attachment_name = map['attachment_name'];
    attachment_size = map['attachment_size'];
    attachment_extension = map['attachment_extension'];
  }
}