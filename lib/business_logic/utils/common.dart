// in this section the most important strings are splitted and dummy characters are added for security purpose

//Message Keys
// KeyString used in encryption service for Message is '12345645678901294564567890123458' splitted into four parts
const String alphaMsg = 'a1@2345645'; // dummy at index (0,2) are (a,@)
const String betaMsg = '67#8g90129'; //  dummy at index (2,4) are (#,g)
const String gammaMsg = '4564o59678'; // dummy at index (4,6) are (o,9)
const String sigmaMsg = '90123465i8'; // dummy at index (6,8) are (6,i)

// IVString used in encryption service for Message is 'a123efgh456lm789' splitted into Two parts
const String zetaMsg = 'a12R3Tefgh'; //  dummy at index (3,5) are (R,T)
const String thetaMsg = '456lm&7%89'; // dummy at index (5,7) are (&,%)

//Persistent Data Keys (Data in table)
// PLEASE DONOT CHANGE THIS KEYS
// THE ONLY SITUATION TO CHANGE IT IS WITH FRESH INSTALLTION
// KeyString used in encryption service for Data is '98765432109876543210987654321098' splitted into four parts
const String alphaData = '5958765432'; // dummy at index (0,2) are (5,5)
const String betaData = '1097837654'; //  dummy at index (3,5) are (7,3)
const String gammaData = '3210980706'; // dummy at index (6,8) are (0,0)
const String sigmaData = '5243210982'; // dummy at index (1,9) are (2,2)

// IVString used in encryption service for Data is 'nji98uhbvgy76tfc' splitted into Two parts
const String zetaData = 'neji98uhbr'; //  dummy at index (1,9) are (e,r)
const String thetaData = 'vgy76tsfdc'; // dummy at index (6,8) are (s,d)
