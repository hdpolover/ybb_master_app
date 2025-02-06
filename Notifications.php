<?php

defined('BASEPATH') or exit('No direct script access allowed');

use chriskacerguis\RestServer\RestController;

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

class Notifications extends RestController
{

  public function __construct()
  {
    parent::__construct();
  }

  // VERIF EMAIL
  public function notify_documents_get()
  {
    $emails = $this->get('emails');
    $emails = explode(',', $emails);

    $program_id = $this->get('program_id');

    // join program category and program
    $this->db->select('program_categories.web_url, program_categories.logo_url, programs.name as program_name');
    $this->db->from('programs');
    $this->db->join('program_categories', 'programs.program_category_id = program_categories.id');
    $this->db->where('programs.id', $program_id);
    $query = $this->db->get();
    $programResult = $query->row_array();

    $logo_url = $programResult['logo_url'];
    $web_url = $programResult['web_url'];
    $program_name = $programResult['program_name'];


    $config = array(
      'protocol' => 'smtp',
      'smtp_host' => 'ssl://smtp.googlemail.com',
      'smtp_port' => config_item('port_email'),
      'smtp_user' => config_item('user_email'),
      'smtp_pass' => config_item('pass_email'),
      'mailtype' => 'html',
      'charset' => 'iso-8859-1',
      'wordwrap' => true,
    );

    $data = array(
      'logo_url' => $logo_url,
      'web_url' => $web_url,
      'program_name' => $program_name,
    );

    // get template file name from db table email_templates where program_id = 1
    $this->db->select('file_name');
    $this->db->from('email_templates');
    $this->db->where('program_id', $program_id);
    $query = $this->db->get();
    $templateResult = $query->row_array();

    $file_name = $templateResult['file_name'];

    // message is from view
    // load view from emails/loa_notif_template.php
    $message = $this->load->view('emails/' . $file_name, $data, TRUE);

    $this->load->library('email', $config);
    $this->email->set_mailtype("html");
    $this->email->set_newline("\r\n");
    $this->email->set_crlf("\r\n");
    $this->email->from(config_item('user_email'));

    $this->email->to($emails);
    // subject is about abstract submission acceptance
    $this->email->subject('Abstract Submission Acceptance' . ' - ' . $event_name);
    $this->email->message($message);
    if ($this->email->send()) {
      $this->response([
        'status' => true,
        'message' => 'Email has been sent',
      ], 200);
    } else {
      $this->response([
        'status' => false,
        'message' => $this->email->print_debugger(),
      ], 404);
    }
  }

  function list_get()
    {
        $paper_detail_id = $this->get('paper_detail_id');

        // get paper revisions use select * from paper_revisions where paper_detail_id = $paper_detail_id and is_active = 1
        $this->db->select('*, paper_reviewers.name as reviewer_name');
        $this->db->from('paper_revisions');
        $this->db->join('paper_reviewers', 'paper_revisions.paper_reviewer_id = paper_reviewers.id');
        $this->db->where('paper_detail_id', $paper_detail_id);
        $this->db->where('paper_revisions.is_active', 1);
        $query = $this->db->get();
        $paper_revisions = $query->result_array();
        if ($paper_revisions) {
            $this->response([
                'status' => true,
                'data' => $paper_revisions
            ], 200);
        } else {
            $this->response([
                'status' => false,
                'message' => 'No result were found'
            ], 404);
        }
    }

}
