<?php

defined('BASEPATH') or exit('No direct script access allowed');

use chriskacerguis\RestServer\RestController;

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

class Program_Loas extends RestController
{

    function __construct()
    {
        parent::__construct();
    }

    function index_get()
    {
        $id = $this->get('id');
        if ($id == '') {
            $loas = $this->mCore->get_data('program_loas', ['is_active' => 1])->result_array();
            if ($loas) {
                $this->response([
                    'status' => true,
                    'data' => $loas
                ], 200);
            } else {
                $this->response([
                    'status' => false,
                    'message' => 'No result were found'
                ], 404);
            }
        } else {
            $loas = $this->mCore->get_data('program_loas', ['id' => $id, 'is_active' => 1])->row();
            if ($loas) {
                $this->response([
                    'status' => true,
                    'data' => $loas
                ], 200);
            } else {
                $this->response([
                    'status' => false,
                    'message' => 'No result were found'
                ], 404);
            }
        }
    }

    function list_get()
    {
        $program_id = $this->get('program_id');

        $loas = $this->mCore->get_data('loas', ['program_id' => $program_id, 'is_active' => 1])->result_array();
        if ($loas) {
            $this->response([
                'status' => true,
                'data' => $loas
            ], 200);
        } else {
            $this->response([
                'status' => false,
                'message' => 'No result were found'
            ], 404);
        }
    }

    function generate_get()
    {
        $program_id = $this->get('program_id');
        $author_names = $this->get('author_names');
        $paper_title = $this->get('paper_title');

        // make names are capitalized on each word
        $author_names = ucwords($author_names);
        $paper_title = ucwords($paper_title);

        $loas = $this->mCore->get_data('program_loas', ['program_id' => $program_id, 'is_active' => 1])->row_array();

        $data = [
            'author_names' => $author_names,
            'paper_title' => $paper_title,
            'template' => $loas['template_name'],
        ];

        // print_r($data);
        // die();
        $this->load->library('pdf');
        $this->pdf->set_paper('A4', 'potrait');
        $this->pdf->filename = $data['author_names'] . ".pdf";
        $this->pdf->load_view('pdf/' . $data['template'], $data);
    }
    
}