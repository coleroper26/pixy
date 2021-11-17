import os
import random
import requests

def main():
    try:
        samples_per_file = 10
        blocklists_dir = '../blocklist'
        protocol       = 'http://'

        # samples
        # bl_samples = get_blocklist_samples(samples_per_file, protocol, blocklists_dir, bl_excl=["malware", "illegal", "pornography"])
        # al_samples = ["http://Alibaba.com", "http://FoxNews.co", "http://Dictionary.com", "http://Hilton.co", "http://TheHill.com", "http://Washington.ed", "http://RedCross.org", "http://Fortune.co", "http://NYU.edu", "http://CBSLocal.co", "http://NetworkAdvertising.org", "http://ChicagoTribune.co", "http://Example.com", "http://Wikia.co", "http://AllAboutCookies.org", "http://NOAA.go", "http://WorldBank.org", "http://Cornell.ed", "http://Ox.ac.u", "http://UN.or", "http://UCLA.edu", "http://CA.or", "http://ScienceMag.org", "http://Photobucket.co", "http://Entrepreneur.com", "http://StarwoodHotels.co", "http://MIT.edu", "http://BBC.co", "http://Apache.org", "http://LATimes.co", "http://Time.com", "http://TypePad.co", "http://DailyMail.co.uk", "http://Go.co", "http://Digg.com", "http://Gravatar.co"]
        # samples = al_samples + bl_samples
        # random.shuffle(samples)

        bl_samples = ["http://arthuriancasino.com", "http://attheraces.co.uk", "http://casino-69.com", "http://chipscasino.com", "http://defeatthecasinos.com", "http://funplanet.com", "http://gamblinglinks.com", "http://geishalounge.com", "http://jackpotking.com", "http://poker-corner.com", "http://primapoker.com", "http://proinfosports.com", "http://slotsoasis.com", "http://tmcards.com", "http://130.94.133.187", "http://209.0.105.83", "http://216.200.199.50", "http://216.34.207.54", "http://64.156.1.160", "http://ad215.paycount.com", "http://ad253.erasercash.com", "http://datais.net", "http://open-x.technic3d.de", "http://r1.sn-5hne6nsr.googlevideo.com", "http://r2.sn-o097znl6.googlevideo.com", "http://zeroredirect1.com", "http://aggravating.net", "http://coverproxy.com", "http://dnsalias.net", "http://filterskip.com", "http://leetchan.org", "http://leum.info", "http://uu.tj", "http://zippyfile.com", "http://12.170.116.68", "http://216.65.124.131", "http://66.223.50.92", "http://cracksinn.com", "http://eztv.ag", "http://free-crack-4you.com", "http://kinokiste.com", "http://kinopoiski.ru", "http://mp3http.com", "http://musicgratis.org", "http://phaze.co", "http://saugking.net", "http://sumotorrent.sx", "http://temagls.blogspot.com", "http://thedarkbay.psb.cu.cc", "http://thepirateproxy.biz", "http://torrent-games.net", "http://torrentbox.com", "http://torrentfunk.com", "http://torrentreactor.net", "http://vidsoft.ru", "http://warezitalia.net", "http://woom.ws", "http://204.228.229.180", "http://209.250.128.48", "http://213.61.105.210", "http://63.251.163.112", "http://64.246.44.69", "http://65.98.41.82", "http://66.194.239.191", "http://81.88.35.41", "http://abbc.com", "http://airgunforum.co.uk", "http://amaf.com.au", "http://chicagohoodz.com", "http://contrelislam.org", "http://duckhuntingchat.com", "http://extremesins.com", "http://extremevideos.org", "http://hsvt.org", "http://jdo.org", "http://jesus-is-lord.com", "http://justpistols.co.uk", "http://marlinfirearms.com", "http://messershop.at", "http://orape.com", "http://propatria.org", "http://quefuerte.com", "http://samuraischwerter.de", "http://shooting-hunting.com", "http://thefirearmsforum.com"]
        print(f"{len(bl_samples)}")

        # test blocked sites 4 times each (340 HTTP requests)
        for i in range(4):
            print(f"[TEST {i}] : BEGIN")
            test_list(bl_samples)
            print(f"[TEST {i}] : COMPLETE\n")



        '''
        # test only allowed sites 10 times each (300 HTTP requests)
        for i in range(10):
            test_list(al_samples)
            print(f"[TEST {i}] : COMPLETE\n")
        '''



        '''
        # test
        print(f"Beginning test with {len(samples)} samples.")
        test_list(samples)
        '''

    except KeyboardInterrupt:
        print("Keyboard interrupt pressed. Exiting.")


def get_blocklist_samples(f_samps, prot, bl_dir, bl_excl=[]):
    sample_lines = []
    blocklists = [f for f in os.listdir(bl_dir) if os.path.isfile(os.path.join(bl_dir, f)) and not f in bl_excl]
    # loop through blocklists
    for blocklist in blocklists:
        # count total number of lines in blocklist
        with open(os.path.join(bl_dir, blocklist), 'r') as f_blocklist:
            for line_count, line in enumerate(f_blocklist):
                pass
        # choose lines to sample from blocklist
        sample_line_nums = random.sample(range(line_count), f_samps)
        # get sample lines
        with open(os.path.join(bl_dir, blocklist), 'r') as f_blocklist:
            for line_num, line in enumerate(f_blocklist):
                if line_num in sample_line_nums:
                    sample_lines.append(prot+line.strip())
    return sample_lines


def test_list(samps, to=2.0):
    samps_failed = 0
    for samp in samps:
        try:
            requests.head(samp, timeout=to)
        except requests.exceptions.RequestException as E:
            # print(f"{samp} failed with {type(E).__name__}")
            samps_failed += 1
            pass

    print(f"{samps_failed} samples failed out of {len(samps)}")


if __name__ == "__main__":
    main()

