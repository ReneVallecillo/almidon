<?
# Description:
#   o Emluate unix tail -f functionality
# ----------------------------------------------
# Program     : tailfile.phpc
# Version     : 1.0
# Author      : Matthew Frederico
# Date        : March 21 2002
# ----------------------------------------------

# Notes       :
#   o vi: set tabstop=4
#   o vi: set shiftwidth=4

class TailFile
{
        // Parameters
        var $interval_sec       = 1;    // Frequency of file checking
        var $linesize           = 1024; // Buffer for line size

        // Variables
        var $DBG                = 1;    // Debug Mode, writes to stdout
        var $filesize           = 0;    // Is current size of tailed file
        var $lastfilesize       = 0;    // Last file size if tailed file
        var $data                       = '';   // Updated data, if tailed file changed
        var $filename           = '';   // Name of the tailed file

        // Flags
        var $not_done           = 0;    // Flag for class
        var $flushdata          = 0;    // Flag to Destroys $data

        #-----------------------------
        # Function declarations
        #-----------------------------

        function TailFile($filename)
        # Declaration:
        #    $object = new TailFile("path/to/filename/to/tail")

        # Description:
        #    Initializes public variables and flags.
        {
                if (file_exists($filename))
                        $this->not_done = 1;
                $this->filename = $filename;
                if ($this->DBG)
                {
                        print ">> Tailing File: ".$this->filename."\n";
                        print ">> Not Done    : ".$this->not_done."\n";
                }
        }

        function checkUpdates()
        # Declaration:
        #    void $object->checkUpdates();

        # Description:
        #    o Checks tailed file for updates
        #    o Injects data varaible with changes.

        # Notes      :
        #    o Initiates a clearstatcache()
        {
                if ($this->not_done)
                {
                        $this->lastfilesize             = $this->filesize;
                        $this->filesize                 = filesize($this->filename);
                        if ($this->DBG)
                        {
                                print ">> Check Updates     : ".$this->not_done."\n";
                                print ">> Last File Size    : ".$this->lastfilesize."\n";
                                print ">> Current File Size : ".$this->filesize."\n";
                        }
                        if ($this->filesize <> $this->lastfilesize)
                        {
                                if ($this->DBG)
                                        print "-->> Opening ".$this->filename."\n";
                                if($fd = fopen($this->filename,"r"))
                                {
                                        if ($this->DBG) print "-->> Opened!\n";

                                        fseek($fd,intval($this->lastfilesize) - intval($this->filesize)-1,SEEK_END);
                                        $i = 0;
                                        while(!(feof($fd)) && (intval($this->lastfilesize) > 0))
                                        {
                                                if ($this->DBG && $i++ == 0) print "-> Scanning File:\n";
                                                $this->data .= fgets($fd,$this->linesize);
                                                if ($this->DBG) print ($i.':'.$this->data);
                                        }
                                        fclose($fd);
                                }
                                else $this->end();
                        }
                        clearstatcache();
                }
        }

        function wait($interval = 0)
        # Declaration:
        #    void $object->wait([int]);

        # Description:
        #    o Sleeps for $interval seconds

        # Notes      :
        #    o If $interval = 0, it is defaulted to $interval_sec
        {
                if ($interval) $this->interval_sec = $interval;
                sleep($this->interval_sec);
        }

        function isOpen()
        # Declaration:
        #    int $object->isOpen(void);

        # Description:
        #    o Checks to see if the tail file is open
        {
                if ($this->DBG) print ">> is Open: ".$this->not_done."\n";
                return $this->not_done;
        }

        function flushData()
        # Declaration:
        #    $object->flushData(void);

        # Description:
        #    o Clears the data variable
        {
                if ($this->DBG) print "-> Flushing Data!\n";
                $this->data = '';
        }

        function getResults()
        # Declaration:
        #    string $object->getResults();

        # Description:
        #    o Returns the current results of data
        #    o Flushes the data varable

        # Notes      :
        #    o Returns 0 if nothing pending.
        {
                $results = $this->data;
                $this->flushData();

                if ($this->DBG) print ">> Getting results ... \n";
                if (strlen($results) > 0)
                {
                        if ($this->DBG) print "----------------------\n".$results."\n";
                        return $results;
                }
                else return 0;
        }

        function end()
        # Declaration:
        #    $object->end();

        # Description:
        #    o Initiates the ending sequence for shutdown

        # Notes      :
        #    o Flushes the data variable
        #    o sets not_done flag to 0.
        {
                $this->data  = '';
                $this->not_done = 0;
        }
}
?>
