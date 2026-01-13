

// function testJaccard() {
//     const hobbiesA = [
//     "hiking",
//     "photography",
//     "travel",
//     "reading",
//     "cooking",
//     "meditation",
//     "journaling",
//     "yoga"
//     ]; // size 8

//     const hobbiesB = [
//     "hiking",
//     "travel",
//     "camping",
//     "photography",
//     "fitness",
//     "running",
//     "gym"
//     ]; // size 7

//     const hobbiesC = [
//     "reading",
//     "writing",
//     "philosophy",
//     "psychology",
//     "chess",
//     "photography",
//     "journaling",
//     "note-taking",
//     "research"
//     ]; // size 9

//     const hobbiesD = [
//     "gaming",
//     "streaming",
//     "esports",
//     "speedrunning",
//     "modding",
//     "hardware",
//     "pc-building",
//     "linux",
//     "emulation",
//     "scripting",
//     "automation"
//     ]; // size 11

//     const hobbiesE = [
//     "cooking",
//     "baking",
//     "nutrition",
//     "food-photography",
//     "meal-prep"
//     ]; // size 5

//     const hobbiesF = [
//     "travel",
//     "language-learning",
//     "spanish",
//     "french",
//     "culture",
//     "history",
//     "photography"
//     ]; // size 7
//     console.log("A and B: ", jaccardSimilarity(hobbiesA, hobbiesB));
//     console.log("A and C: ", jaccardSimilarity(hobbiesA, hobbiesC));
//     console.log("A and D: ", jaccardSimilarity(hobbiesA, hobbiesD));
//     console.log("A and E: ", jaccardSimilarity(hobbiesA, hobbiesE));
//     console.log("A and F: ", jaccardSimilarity(hobbiesA, hobbiesF));

//     console.log("B and C: ", jaccardSimilarity(hobbiesB, hobbiesC));
//     console.log("B and D: ", jaccardSimilarity(hobbiesB, hobbiesD));
//     console.log("B and E: ", jaccardSimilarity(hobbiesB, hobbiesE));
//     console.log("B and F: ", jaccardSimilarity(hobbiesB, hobbiesF));

//     console.log("C and D: ", jaccardSimilarity(hobbiesC, hobbiesD));
//     console.log("C and E: ", jaccardSimilarity(hobbiesC, hobbiesE));
//     console.log("C and F: ", jaccardSimilarity(hobbiesC, hobbiesF));

//     console.log("D and E: ", jaccardSimilarity(hobbiesD, hobbiesE));
//     console.log("D and F: ", jaccardSimilarity(hobbiesD, hobbiesF));

//     console.log("E and F: ", jaccardSimilarity(hobbiesE, hobbiesF));
// }
// testJaccard();



// function testKernel() {
//     const center: [number, number] = [-73.5673, 45.5017]; // Montreal downtown
//     const one: [number, number] = [-73.5645, 45.5030]
//     const two: [number, number] = [-73.5455, 45.4950]
//     const three: [number, number] = [-73.5200, 45.4900]
//     const four: [number, number] = [-73.4950, 45.4850]
//     const five: [number, number] = [-73.4500, 45.4750]

//     console.log("score center, one: ", location_score(center, one))
//     console.log("score center, two: ", location_score(center, two))
//     console.log("score center, three: ", location_score(center, three))
//     console.log("score center, four: ", location_score(center, four))
//     console.log("score center, five: ", location_score(center, five))
// }
// testKernel();