const { GoogleSpreadsheet } = require('google-spreadsheet');

module.exports = class Sheet {
  constructor() {
    this.doc = new GoogleSpreadsheet('19dt1BKBb63UGZ-T0iKjnXJFN8PlJQfc3IqH0IsBkFrs');
  }

  async load() {
    await this.doc.useServiceAccountAuth(require('../google-credentials.json'));

    // await this.doc.updateProperties({ title: 'Spider Test' });
  
    await this.doc.loadInfo(); // loads document properties and worksheets
  }
  async addSheet(title, headerValues) {
    await this.doc.addSheet({title, headerValues});

    return this.doc.sheetsByIndex.length - 1;
  }
  async addOrGetSheet(title, headerValues) {
    const sheet = await this.doc.sheetsByTitle[title];

    if (typeof sheet === 'undefined') {
      return await this.addSheet(title, headerValues);
    }

    return sheet;
  }
  async addRows(rows, sheet_index = 0) {
    // const sheet = await doc.addSheet({ headerValues: ['name', 'email'] });
    const sheet = await this.doc.sheetsByIndex[sheet_index];

    await sheet.addRows(rows);
  }
  async getRows(sheet_index = 0) {
    // const sheet = await doc.addSheet({ headerValues: ['name', 'email'] });
    const sheet = await this.doc.sheetsByIndex[sheet_index];

    return await sheet.getRows();
  }

  async debug(sheet_index = 0) {
    console.log(sheet_index);
    const sheet = await this.doc.sheetsByIndex[sheet_index];

    console.log(sheet.title);
    console.log(sheet.rowCount);
    console.log(sheet.cellStats);
    console.log(sheet.cellStats.total);
    console.log(sheet.cellStats.rowCount);
    console.log(sheet.cellStats.columnCount);
    console.log(sheet.cellStats.loaded);
    console.log(sheet.cellStats.nonEmpty);
    console.log('----------------------------------------------------------------------');
    
    const rows = await sheet.getRows();
    console.log(rows);
    console.log('----------------------------------------------------------------------');
  }
}

// (async function() {
//   const sheet = new Sheet()

//   await sheet.load();

//   await sheet.addRows([
//     { title: 'Software Engineer', location: 'Sydney' },
//     { title: 'Designer', location: 'Brisbane' },
//   ])
// })()
 
// const sheet = doc.sheetsByIndex[0]; // or use doc.sheetsById[id]
// console.log(sheet.title);
// console.log(sheet.rowCount);
 
// // adding / removing sheets
// const newSheet = await doc.addSheet({ title: 'hot new sheet!' });
// await newSheet.delete();