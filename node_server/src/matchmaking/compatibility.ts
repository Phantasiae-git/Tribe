import location_score from './location.ts'
import {User, mbtiGraph, mbtiLine} from './objects.ts'

// used to calculate similarity of 2 lists eg: hobbies, places of interest, etc. into number between 0 and 1
function jaccardSimilarity(a: readonly string[], b: readonly string[]): number {

    const setA = new Set(a);
    const setB = new Set(b);

    let intersection = 0;
    for (const item of Array.from(setA)) {
    if (setB.has(item)) intersection++;
    }
    const union = setA.size + setB.size - intersection;
    if (union === 0)
        return 0;
    return parseFloat(Math.sqrt(intersection / union).toFixed(2)); // using square root to soften for short lists
} // to test

function hardCompatibility(node1: User, node2: User): boolean {
    // age of users don't align with age wanted for other group members
    if (node2.age < node1.ageRange[0] || node2.age > node1.ageRange[1]! || node1.age < node2.ageRange[0]! || node1.age > node2.ageRange[1]!)
        return false;
    // gender not aligning with user's preference if preference is mentionned
    if (node1.preferedRoomateGender !== undefined)
        if (node1.preferedRoomateGender != node2.gender)
            return false;
    if (node2.preferedRoomateGender !== undefined)
        if (node2.preferedRoomateGender != node1.gender)
            return false;
    // if user does not want to live with animals, return false for graph
    if (!node1.okWithAnimals && node2.animals.hasAnimals || !node2.okWithAnimals && node1.animals.hasAnimals)
        return false;
    if (!node1.smokingTolerant && node2.smokes || !node2.smokingTolerant && node1.smokes)
        return false;
    return true;
}

export default function compatibility(node1: User, node2: User): number { // function that calculates compatibility
    let compatibility: number = 0;
    // deal breakers:
    if (!hardCompatibility(node1, node2))
        return 0;
    // compatibility:
    let location: number = 0;
    for (const loc1 of node1.intendedMovingLocations) {
        for(const loc2 of node2.intendedMovingLocations) {
            let potential = location_score(loc1.center, loc2.center, loc1.sigmaKm, loc2.sigmaKm) // will be changed to the way the user inputs their location preferences
            location = Math.max(location, potential); // number from 0 to 1
        }
    }
    let hobbyCompatibility = jaccardSimilarity(node1.hobbies, node2.hobbies);
    let placesOfInterestCompatibility = jaccardSimilarity(node1.placesofInterest, node2.placesofInterest);
    let mbtiCompatibility = mbtiGraph[mbtiLine.indexOf(node1.mbti), mbtiLine.indexOf(node2.mbti)]
    // add places of commute
    // add moving date

    
    return compatibility;
}

// export function createGraph() {

// }