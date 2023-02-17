___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "HQ revenue Pixel",
  "brand": {
    "id": "brand_dummy",
    "displayName": "",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAIAAAADnC86AAAAAXNSR0IB2cksfwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAkNJREFUeJzt1ktLG1EUAGB/i6lFqNaCIhSkrYoUu6qi4EKoKzdtsXQt3VmXithFjSY1vk2JihUbE61KXWg08YHOO++YmWRiHGd+gMdEReNkksjMFSTDWYSby3xz7j33zBQUDmAPEgV5OA8/Crh51v3V7kcN6/TY6D73apxCDb+3MANOVod4qZ/osRUmVjdFX48gghsszNg+BzxqeBaLlpuImyMoYNjdfkc4ZRAFbNrjaibplEHNYUh3ZI+7O64tDNX073YxI4IbLO5BJyv7l4YwtKrxA65qjFIBLjEQdpqPCSJU6dNBXHnyOzPzc0c+3Zzhns1jKXEJotQ441ZOF1SwVYCL9JjlKJKERUn6S/LVE/LLCNE67zHusjp92rvlAHeuBihOWHXHeEH84Qh3b4ToiPDF7tfJTZ7Do8pLkhUM2/l9I7TuiVWOkCm7aKP5ZYZ/czv1evPFi6gofbpZwSUGfJHk5/HocyMhO6F90Yuxp7AGL34R5cPER6vPSvEvR0nl22aAnyVUg4uFHwrTKkzkzFFkJxB3BuPJIvjwx3t/uHaStlF87+ZxxpNTmGhSn5d8Z2LSlUxybTIrGJqOIxDvXAsqVGZKlBrx7cBFxsB32Pz3gd9O065gHHYrS/I66s1031YYHle5suThT1YfnJOWOU+uak5xCcMuflsP/j6MDLnYLf/J6/SdQWW4bcF7elUYTYoHX2W4639IurrgsxsdDJ8moZMzUKGmiocyHx7VYAh4ccKpL0vTnjSEEUcezsOaxTlT2jI/KFjW6QAAAABJRU5ErkJggg\u003d\u003d"
  },
  "description": "Integrate booking intents from your website to HQ revenue Performance Board.",
  "categories": [
    "ANALYTICS",
    "SALES"
  ],
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "organizationID",
    "displayName": "Organization ID (Get it with our support)",
    "simpleValueType": true
  },
  {
    "type": "GROUP",
    "name": "BookingParameters",
    "displayName": "Booking Parameters",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "TEXT",
        "name": "arrivalDate",
        "displayName": "Value of the arrival date. (YYYY-MM-DD according ISO-8601)",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "departureDate",
        "displayName": "Value of the departure date. (YYYY-MM-DD according ISO-8601)",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "adultCount",
        "displayName": "Number of adults",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "kidsCount",
        "displayName": "Number of children",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "roomCount",
        "displayName": "Number of rooms",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "hotelID",
        "displayName": "Identification of the selected hotel (Only for hotel chains)",
        "simpleValueType": true
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Sandbox imports
const queryPermission = require('queryPermission');
const sendPixel = require('sendPixel');
const encodeUri = require('encodeUri');
const encodeUriComponent = require('encodeUriComponent');

// Process data types
const organization = data.organizationID;
const hotel = data.hotelID;
const arrival = data.arrivalDate;
const departure = data.departureDate;
const adults = data.adultCount;
const kids = data.kidsCount;
const rooms = data.roomCount;

// Build HQ Pixel URL
let pixelUrl = 'https://script.nowhq.com/pick/pxl/';
    pixelUrl += encodeUri(organization);
    pixelUrl += '?hotelId=' + encodeUriComponent(hotel || '');
    pixelUrl += '&arrivalDate=' + encodeUriComponent(arrival || '');
    pixelUrl += '&departureDate=' + encodeUriComponent(departure || '');
    pixelUrl += '&adultCount=' + encodeUriComponent(adults || '');
    pixelUrl += '&kidsCount=' + encodeUriComponent(kids || '');
    pixelUrl += '&roomCount=' + encodeUriComponent(rooms || '');

// Check for the permissions
if(queryPermission('send_pixel', pixelUrl)) {
  // Fetch teh pixel
  sendPixel(
    pixelUrl,
    data.gtmOnSuccess,
    data.gtmOnFailure
  );
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "send_pixel",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://script.nowhq.com/pick/pxl/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: It should call pixel with empty values queries
  code: "// Mocked template parameters\nconst mockData = {\n  organizationID: organization,\n\
    \  hotelID: '',\n  arrivalDate: '',\n  departureDate: '',\n  adultCount: '',\n\
    \  kidsCount: '',\n  roomCount: '',\n  transformDates: false,  \n};\n\n// Expected\
    \ values\nlet pixelUrl = pixelDomain;\n    pixelUrl += organization;\n    pixelUrl\
    \ += '?hotelId=';\n    pixelUrl += '&arrivalDate=';\n    pixelUrl += '&departureDate=';\n\
    \    pixelUrl += '&adultCount=';\n    pixelUrl += '&kidsCount=';\n    pixelUrl\
    \ += '&roomCount=';\n\n// Mock sendPixel API\nmock('sendPixel', function(url,\
    \ onSuccess, onFailure) {\n  assertThat(url).isEqualTo(pixelUrl);\n  onSuccess();\n\
    });\n\n// Call runCode to run the template's code.\nrunCode(mockData);\n\n// Verify\
    \ that the tag finished successfully.\nassertApi('queryPermission').wasCalledWith('send_pixel',\
    \ pixelUrl);\nassertApi('sendPixel').wasCalled();\nassertApi('gtmOnSuccess').wasCalled();"
- name: it should call pixel with default dates
  code: "// Mocked template parameters\nconst mockData = {\n  organizationID: organization,\n\
    \  hotelID: hotel,\n  arrivalDate: arrival,\n  departureDate: departure,\n  adultCount:\
    \ adults,\n  kidsCount: kids,\n  roomCount: rooms,\n  transformDates: false,\n\
    \  \n};\n\n// Expected values\nlet pixelUrl = pixelDomain;\n    pixelUrl += organization;\n\
    \    pixelUrl += '?hotelId=' + hotel;\n    pixelUrl += '&arrivalDate=' + arrival;\n\
    \    pixelUrl += '&departureDate=' + departure;\n    pixelUrl += '&adultCount='\
    \ + adults;\n    pixelUrl += '&kidsCount=' + kids;\n    pixelUrl += '&roomCount='\
    \ + rooms;\n\n// Mock sendPixel API\nmock('sendPixel', function(url, onSuccess,\
    \ onFailure) {\n  assertThat(url).isEqualTo(pixelUrl);\n  onSuccess();\n});\n\n\
    // Call runCode to run the template's code.\nrunCode(mockData);\n\n// Verify that\
    \ the tag finished successfully.\nassertApi('queryPermission').wasCalledWith('send_pixel',\
    \ pixelUrl);\nassertApi('sendPixel').wasCalled();\nassertApi('gtmOnSuccess').wasCalled();"
- name: It should use numeric values properly (cases for adultCount, kidsCount and
    roomCount)
  code: |-
    // Mocked template parameters
    const mockData = {
      organizationID: organization,
      hotelID: hotel,
      arrivalDate: arrival,
      departureDate: departure,
      adultCount: 2,
      kidsCount: 1,
      roomCount: 1,
      transformDates: false,
    };

    // Expected values
    let pixelUrl = pixelDomain;
        pixelUrl += organization;
        pixelUrl += '?hotelId=' + hotel;
        pixelUrl += '&arrivalDate=' + arrival;
        pixelUrl += '&departureDate=' + departure;
        pixelUrl += '&adultCount=' + adults;
        pixelUrl += '&kidsCount=' + kids;
        pixelUrl += '&roomCount=' + rooms;

    // Mock sendPixel API
    mock('sendPixel', function(url, onSuccess, onFailure) {
      assertThat(url).isEqualTo(pixelUrl);
      onSuccess();
    });

    // Call runCode to run the template's code.
    runCode(mockData);

    // Verify that the tag finished successfully.
    assertApi('queryPermission').wasCalledWith('send_pixel', pixelUrl);
    assertApi('sendPixel').wasCalled();
    assertApi('gtmOnSuccess').wasCalled();
setup: |-
  const pixelDomain = 'https://script.nowhq.com/pick/pxl/';
  const organization = 'ABC';
  const hotel = 41;
  const arrival = '2022-09-01';
  const departure = '2022-09-10';
  const adults = '2';
  const kids = '1';
  const rooms = '1';


___NOTES___

Created on 31/08/2022, 23:16:30


