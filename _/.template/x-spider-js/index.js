const Sheet = require('./sheet');
const fetch = require('node-fetch');
const cheerio = require('cheerio');
// const $ = cheerio.load('<h2 class="title">Hello world</h2>');

// const fs = require('fs');


// Get Data
async function scrapePage(page_no) {
    // const res = await fetch(`https://jobs.github.com/positions.json?page=${page_no}&search=`)
    // const json = await res.json();
    // const text = await res.text();
  
    // const found = text.toLowerCase().includes('xxx');
    // console.log(text);
    // console.log({found});

    // const rows = json.map(job => {
    //   return {
    //     date: job.created_at,
    //     type: job.type,
    //     url: job.url,
    //     company: job.company,
    //     company_url: job.company_url,
    //     location: job.location,
    //     // description: job.description,
    //     how_to_apply: job.how_to_apply,
    //     company_logo: job.company_logo
    //   }
    // });

    // return rows;
  
}

(async function() {

  // let page = 1;
  // let rows = [];

  // while(true) {
  //   const newRows = await scrapePage(page);

  //   if (newRows.length === 0) break;

  //   rows = [...rows, ...newRows];
  //   page++;

  //   console.log('new row length', newRows.length);
  // }
  // console.log('allll row length', rows.length);

  // // Write Data
  // const sheet = new Sheet();
  // await sheet.load();
  // await sheet.addRows(rows);
})()
