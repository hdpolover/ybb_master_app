<?php
// date
$date = date('F d, Y');
$paper_title = 'The Impact of Climate Change on Biodiversity';
$presenters = 'Dr. John Doe, Dr. Jane Doe';
$path = "https://storage.ybbfoundation.com/logo/YAF.png";
$type = pathinfo($path, PATHINFO_EXTENSION);
$data = file_get_contents($path);
$logo = 'data:image/' . $type . ';base64,' . base64_encode($data);

 $path_sign = "https://storage.ybbfoundation.com/document_invitation/3/1.png";
        $type_sign = pathinfo($path_sign, PATHINFO_EXTENSION);
        $data_sign = file_get_contents($path_sign);
        $img_sign = 'data:image/' . $type_sign . ';base64,' . base64_encode($data_sign);
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Conference Acceptance Letter</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      font-size: 12px;
      width: 100%;
      min-height: 100%;
      margin-right: 20px;
      padding: 2%;
    }

    .header {
      display: grid;
      grid-template-columns: 1fr 1fr 1fr;
      /* Changed to three equal columns */
      gap: 20px;
      align-items: center;
      margin-bottom: 12%;
      padding: 5px;
    }

    .logo {
      float: left;
      width: 20%;
    }

    .event-info {
      /* Center the middle column */
      text-align: start;
      /* Center the text within */
      float: left;
    }

    .contact-info {
      justify-self: end;
      /* Align contact info to end of last column */
      text-align: right;
      float: right;
      width: 30%;
      line-height: 1.1;
    }

    .new-tab {
      text-indent: 20px;
      text-align: justify;
    }

    .title {
      font-size: 16px;
      margin: 10px 0;
      font-weight: bold;
      text-align: center;
    }

    .content {
      margin-top: 10px;
      line-height: 1.5;
      padding: 5px;
      text-align: justify;
    text-justify: inter-word;
    }

    .content ul {
      padding-left: 20px;
    }

    .content ul li {
      margin: 5px 0;
    }

    .date-section {
      display: flex;
      justify-content: flex-end;
      margin: 20px 0;
    }

    .signature {
      margin-top: 10px;
      padding: 5px;
      display: flex;
      line-height: 1.3;
      flex-direction: column;
      gap: 5px;
    }

    .footer {
      margin-top: 10px;
      font-size: 11px;
      line-height: 1.3;
      padding: 5px;
      text-align: center;
    }

    a {
      color: #000;
      text-decoration: none;
    }

    a:hover {
      text-decoration: underline;
    }
    
    .parent {
  position: relative;
  top: 10;
  bottom: 30;
  left: 0;
}
.image1 {
  position: relative;
  top: 0;
  left: 0;
}
.image2 {
  position: absolute;
  top: 20px;
  left: 20px;
}

  </style>
</head>

<body>
  <!-- Header -->
  <header class="header">
    <div class="logo">
      <img style="width: 100px; height: auto;"
        src="<?= $logo ?>"
        alt="Youth Academic Forum Logo" />
    </div>
    <div class="event-info">
  <p class="title"><strong>Youth Academic Forum 2025</strong></p>
  <p><strong>Research Beyond Borders</strong></p>
</div>

    <div class="contact-info">
  <p>
    <a href="http://www.youthacademicforum.com">www.youthacademicforum.com</a>
  </p>
  <p>youthacademicforum@gmail.com</p>
  <p>+62 851-7338-6622 (YBB Admin)</p>
</div>

  </header>

  <hr />
  
  </br>

  <!-- Title -->
  <h1 class="title">Conference Acceptance Letter</h1>

  <!-- Date -->
  <div style="text-align: right;">
    <p>
      <?= $date ?>
    </p>
  </div>

  <!-- Content -->
  <div class="content">
    <p>Dear researcher,</p>
    <p class="new-tab">
  We are delighted to inform you that your abstract has been accepted for presentation at <strong>The Youth Academic Forum (YAF 2025)</strong>. The conference will take place from <strong>May 5 to May 8, 2025</strong>, in the vibrant and culturally rich city of <strong>Bangkok, Thailand</strong>.
</p>
    <p class="new-tab">
      The Youth Academic Forum is an esteemed global platform that fosters collaboration, innovation, and knowledge sharing among young and dynamic researchers. It is a venue where thought leaders, academics, and professionals come together to discuss pressing global issues and share solutions that have a meaningful impact on the world. Your work has been carefully selected as it aligns with the spirit of innovation and excellence that defines this event, and we are truly honored to have your valuable contributions included.
    </p>
    <p>Below are the details of the paper:</p>
    <ul>
      <li>
        <strong>Paper Title:</strong>
        <?= $paper_title ?>
      </li>
      <li>
        <strong>Presenter(s):</strong>
        <?= $presenters ?>
      </li>
      <li>
        <strong>Conference Website:</strong>
        <a href="http://www.youthacademicforum.com">www.youthacademicforum.com</a>
      </li>
    </ul>

    <p class="new-tab">
      We encourage you to explore our official website and social media channels for the latest updates and the finalized conference agenda, which will be shared closer to the event date. These platforms are designed to ensure you remain well-informed about the event proceedings, keynote sessions, networking opportunities, and any additional information you may need.
    </p>
    
    <p class="new-tab">
  If you have specific questions or require any assistance, please do not hesitate to contact us directly at <strong><a href="mailto:youthacademicforum@gmail.com">youthacademicforum@gmail.com</a></strong>. Our team is here to support you and ensure your participation in this event is smooth and rewarding.
</p>

    <p class="new-tab">
      We look forward to welcoming you to Bangkok, where you will join a diverse group of passionate researchers and leaders. Your participation will undoubtedly enrich the discussions and inspire meaningful dialogue. Thank you for being a part of YAF 2025, and we are excited to meet you in person!
    </p>
  </div>

  <!-- Signature -->
  <div class="signature">
    <p>Sincerely,</p>
      
        <div class="parent">
                    <img class="image1" src="<?= $logo ?>" style="opacity: 0.5; width: 150px; height: auto;" alt="">
                    <img class="image2" src="<?= $img_sign ?>" alt="" width="100px;">
                </div>
                <br>
    <p>
       <strong>Muhammad Aldi Subakti</strong> 
       </br>
    <span>Chairman of Youth Academic Forum</span>
    </p>
    
  </div>
  
  <!-- Footer -->
  <footer class="footer">
  <p>
    <strong>Youth Academic Forum 2025</strong></br> 
    Organized by <strong>Youth Break the Boundaries Foundation</strong><br />
    <strong><a href="http://www.youthacademicforum.com">www.youthacademicforum.com</a> | 
    <a href="mailto:youthacademicforum@gmail.com">youthacademicforum@gmail.com</a> | 
    +62 851-7338-6622</strong> (YBB Admin)
  </p>
</footer>

</body>

</html>