# RailsCalibration
## What is it?

> My first open source (GNU V3) Ruby on Rails application that tracks business assets requiring periodic calibration or re-certification.

## Feature list (incomplete)

* Single user (currently)
* A stationary navigation bar to the left of the page with links to all the functionality
* A summary page where you can see:
  * A list of items due to be calibrated
    * With a 300x300 picture of the item
    * When it was due
    * A link to send the item out to be calibrated
* A list of items due to be calibrated today
* Show what's due in the next thirty days
* Display a list of items out for calibration
* List inactive items
* Calibrators page (bad name?)
  * Show your vendors
  * See what items you've sent them for the past year
  * Show costs
* Issues page
  * Keep a list of problems or comments on the item
* Dependants
  * List equipment or processes that a particular item being out for calibration would affect
* Events
  * Accessed through Items
    * Show current and past calibration events
    * Date
    * PO
    * Cost
    * Certification PDF or image stored via PaperClip
* Documents
  *Store related documents in PDF of JPEG formats
    * manuals
    * test setups

## Why is it needed?
> I work as a technician in a small FAA approved repair station which has quite a few items that need to be calibrated on a yearly basis, but not nearly so many that we have invested in an "Off the Shelf" solution.

> Currently, a spreadsheet is used to track items. This works well if you have less than 100 items to track. It doesn't work as well above this number and causes us to spend an increasing amount of time physically verifying the dates on test equipment each month.

> Enter Ruby on Rails

> One thing I have always wanted to do was create an open source project as a way to give something back to the community that has taught me so much.

## Details

### Items

The Items table is the centerof the app. It containes the basic information about an item, it's model number, serial number, etc.

It also is related to events, vendors, depenents, issues, and documents.

### Events

An event occurs when the item is calibrated. It stores the vendor as well as a copy of the certification.

### Dependents 

Many times a piece of test equipment directly supports a specific process and can't be replaced. So if the equipment goes out for cal, the process has to wait.

### Issues

When something happens to the equipment, it can be recorded here.

### Documents

Manuals or notes from the technician can be stored here
