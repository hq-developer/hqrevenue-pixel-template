# HQ revenue Pixel template
HQ revenue's pixel for Google Tag Manager integrations

## Introduction

The HQ revenue's Pixel template makes it easy for hotels, IBEs and OTAs to send booking intentions to HQ revenue's Performance Board.

## Configuration

Once you have GTM up and running, simply create a new tag, and search for our template in the community gallery.
Fill in the parameters needed, test the integration, and publish it.

### Parameters Description 

#### 1. Organization ID
You will get this value with our support or sales teams. It is a long identifier id for your organization.

#### 2. Value of the arrival date
This is the check-in date your guest are searching for.

1. Use a GTM variable to point in this field
2. It is important that your dates are formatted according the ISO-8601 standard. You can find more about date formats bellow in this document.

#### 3. Value of the departure date
This is the check-out date your guest are searching for.

1. Use a GTM variable to point in this field
2. It is important that your dates are formatted according the ISO-8601 standard. You can find more about date formats bellow in this document.

#### 4. Number of adults
This is the amount of adult guests your customers are searching for.

1. Use a GTM variable to point in this field

#### 5. Number of children
This is the amount of kids children or infants guests your customers are searching for.

1. Use a GTM variable to point in this field
2. HQ revenue api does not differentiate children per age. 
If you system does it, please configure a GTM variable that can send to our pixel a summed value.

#### 6. Number of rooms
This is the amount of rooms your customers are searching for.

1. Use a GTM variable to point in this field
2. HQ revenue api does not differentiate types of rooms.
   If you system does it, please configure a GTM variable that can send to HQ Pixel a sum of all booking rooms.

#### 7. Identification of the selected hotel (Only for hotel chains)
This is the identification of the hotel of your chain your customers are searching for.

1. Use a GTM variable to point in this field
2. This is an important parameter for hotel chains. Leave it blank if your organization has only one hotel.

## About General Data Protection Regulation (GDRP)

The booking intent information does not fall in GDRP, because HQ revenue does not apply any user identification method.
Our goal is to evaluate the intentions of your users, but not to identify them.

Though HQ revenue does not use any tracking method, the "pixel tracking" mechanism is very popular for tracking purposes,
And GTM, or browser's extensions, can disable it if the user does not agree with during cookies acceptance setup.

Our HQ revenue Script template solution can be another option to avoid the problem.

## More About ISO-8601 date format
> IMPORTANT!
> If your system is already using dates according the ISO-8601 Standard, meaning, dates as 2022-12-25 to represent 25th of December 2022,
> you can ignore this section.

The ISO-8601 standard is an international adopted standard used by HQ revenue, because "the standard provides a well-defined,
unambiguous method of representing calendar dates and times in worldwide communications, especially to avoid
misinterpreting numeric dates and times when such data is transferred between countries with different conventions for
writing numeric dates and times." (https://en.wikipedia.org/wiki/ISO_8601)

The ISO-8601 standard define date format as YYYY-MM-DD. Example: 2022-12-25.

If your system does not work with ISO date standards, you can use some Custom Javascript variables to convert your date
format to ISO format before connecting it to HQ revenue Pixel template. Let's see how to create variables that can do the 
date conversion.

Imagine the scenario in which you have no GTM variable setup, and the date is available only in you HTML document. The HTML
document would look the example bellow:
```html
<body>
    <h1>Booking example</h1>
    <section>
      <span id="check-in">05 October 2022 14:00 UTC</span>
      <span id="check-out">10 October 2022 12:00 UTC</span>

      <button>Book Now</button>
    </section>
  </body>
```

Whe can break this problem in two steps:
1. Create a variable `checkInField` that stores the date from the HTML;
2. Create a variable `checkInDate` that converts the value of `checkInField` to the ISO-8601 format.

**Step one:**
* In GTM, in the lest-side menu, we navigate to the `Variables`;
* In User-Defined Variables, we click on `NEW`;
* On the top panel where we see "Untitled Variable" we type `checkInField`;
* Clicking on the "Variable Configuration" panel, we select the `DOM Element` variable template;
* Selecting `ID` as selection method, we type `check-in` (pay attention on the id parameter of your HTMl element. Our case is "check-in");
* Now we save the variable.

From this point onwards, the variable `checkInField` will hold the value "05 October 2022 14:00 UTC" from our HTML element.

**Step two:**
* Again in the GTM's Variables section, we create a new User-Defined variable;
* We name this one as `checkInDate` and once clicked in "Variable Configuration" we select the `Custom Javascript` template;
* In the Custom Javascript template we type the following code:
```javascript
function() {
  return new Date({{checkInField}}).toISOString();
}
```
* New we save the variable.

After these steps, you can connect the variable `checkInDate` to the HQ revenue Pixel template.
