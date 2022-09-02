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
  "displayName": "HQ revenue\u0027s Pixel",
  "brand": {
    "id": "brand_dummy",
    "displayName": ""
  },
  "description": "Send data to HQ via GET requests.\nSetup your \"OrganizationID\", and refer to our documentation at: hqrevenue.com/knowledgebase",
  "categories": [
    "MARKETING",
    "SALES"
    "TAG_MANAGEMENT",
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
    "name": "BookingVariables",
    "displayName": "Booking Variables",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "TEXT",
        "name": "arrivalDate",
        "displayName": "Value of the arrival date",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "departureDate",
        "displayName": "Value of the departure date",
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
        "displayName": "Identification of the selected hotel",
        "simpleValueType": true
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "ApplyDateTransformation",
    "displayName": "Should dates be formatted to ISO Standard",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "transformDates",
        "checkboxText": "Yes, transform my dates.",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "datePattern",
        "displayName": "Your date\u0027s format description. In ISO duration, eg: DD.MM.YYYY, or MM.DD.YY",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "transformDates",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "convertFunction",
        "displayName": "The convert date function.",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "transformDates",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Sandbox imports
const queryPermission = require('queryPermission');
const sendPixel = require('sendPixel');
const getType = require('getType');
// const log = require('logToConsole');

// Process data types
const organization = data.organizationID;
const hotel = data.hotelID;
const arrival = data.transformDates ? data.convertFunction(data.arrivalDate, data.datePattern) : data.arrivalDate;
const departure = data.transformDates ? data.convertFunction(data.departureDate, data.datePattern) : data.departureDate;
//const adults = getType(data.adultCount) === 'number' ? data.adultCount.toString() : data.adultCount;
//const kids = getType(data.kidsCount) === 'number' ? data.kidsCount.toString() : data.kidsCount;
//const rooms = getType(data.roomCount) === 'number' ? data.roomCount.toString() : data.roomCount;
const adults = data.adultCount;
const kids = data.kidsCount;
const rooms = data.roomCount;

// Build HQ Pixel URL
let pixelUrl = 'https://s8qyj1.sse.codesandbox.io/pixel/';
    pixelUrl += organization;
    pixelUrl += '?hotelId=' + (hotel || '');
    pixelUrl += '&arrivalDate=' + (arrival || '');
    pixelUrl += '&departureDate=' + (departure || '');
    pixelUrl += '&adultCount=' + (adults || '');
    pixelUrl += '&kidsCount=' + (kids || '');
    pixelUrl += '&roomCount=' + (rooms || '');

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
                "string": "https://s8qyj1.sse.codesandbox.io/pixel/*"
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
- name: it should call pixel with formated dates
  code: "function mockedTransformFunction(date, pattern){\n  // Asserts that the pattern\
    \ was sent to the convertion function\n  assertThat(pattern).isEqualTo('DD/M/YY');\n\
    \  \n  if (date === '01/9/22') {\n    return '2022-09-01';\n  } else if (date\
    \ === '10/9/22') {\n    return '2022-09-10';\n  } else {\n    return '';\n  }\n\
    }\n\n// Mocked template parameters\nconst mockData = {\n  organizationID: organization,\n\
    \  hotelID: hotel,\n  arrivalDate: '01/9/22',\n  departureDate: '10/9/22',\n \
    \ adultCount: adults,\n  kidsCount: kids,\n  roomCount: rooms,\n  transformDates:\
    \ true,\n  datePattern: 'DD/M/YY',\n  convertFunction: mockedTransformFunction,\n\
    };\n\n// Expected values\nlet pixelUrl = pixelDomain;\n    pixelUrl += organization;\n\
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
  const pixelDomain = 'https://s8qyj1.sse.codesandbox.io/pixel/';
  const organization = 'ABC';
  const hotel = 41;
  const arrival = '2022-09-01';
  const departure = '2022-09-10';
  const adults = '2';
  const kids = '1';
  const rooms = '1';


___NOTES___

Created on 31/08/2022, 23:16:30


