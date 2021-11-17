<?php
    ini_set('display_errors', 1);
    if(isset($_POST['submit']))
    {

        # redirect back to index.html
        header('Location: index.html', true);

        # escape shell arguments
        $advert = escapeshellarg($_POST['advert']);
        $bypass = escapeshellarg($_POST['bypass']);
        $gambling = escapeshellarg($_POST['gambling']);
        $illegal = escapeshellarg($_POST['illegal']);
        $malware = escapeshellarg($_POST['malware']);
        $pornography = escapeshellarg($_POST['pornography']);
        $torrent = escapeshellarg($_POST['torrent']);
        $violence = escapeshellarg($_POST['violence']);

        # update filters
        exec("sudo /pixy/util/update-filters.sh $advert $bypass $gambling $illegal $malware $pornography $torrent $violence", $output);
    }
?>
