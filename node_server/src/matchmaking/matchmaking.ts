import location_score from './location.js'

// undefined: not available
// 0.5: has but limited
// 1: fully available
type Level = undefined | number;

type LocationPreference = {
    center: [ lon: number, lat: number ]
    sigmaKm: number
    weight?: number // importance of location to live
}

type Locations = LocationPreference[]

type Animals = {
    hasAnimals: boolean
    animalTypes?: string[]
    animalNum?: number
}

type Subscriptions = {
    netflix?: Level
    prime?: Level
    max?: Level
    plex?: Level
    spotify?: Level
    steam?: Level
    //etc
}

type Skill = {
    level: Level
    willingness?: Level
}

type Skills = {
    cooking?: Skill
    houseRepairs?: Skill
    bricollage?: Skill // ??
    cleaning?: Skill
    sewing?: Skill
    finances?: Skill
    //etc
}

type User = {
    username: string | null
    name: string | null
    id: number

    age: number //
    ageRange: [min: number, max: number] //
    gender: number // 0 for woman and 1 for man and 2 for other
    preferedRoomateGender: number | undefined // 0 for woman and 1 for man and 2 for other
    smokes: boolean
    smokingTolerant: boolean
    okWithAnimals: boolean
    animals: Animals

    occupation: string
    student: boolean

    intendedMovingLocations: Locations
    intendedMovingDate: number | string // not sure yet should be from 0 to 3 of how soon or something similar
    dailyCommuteAreas: Locations // might use jaccard depending or gaussian kernel
    subscriptions: Subscriptions
    skills: Skills

    mbti: string
    placesofInterest: string[] // gym, library, etc 
    hobbies: string[]
    drivingLicense: boolean
    ownsCar: boolean
    
    currentLocation: [lon: number, lat: number]
    incomeLevel: number // from 0 to 5 or something similar

}

const skillImportance = 0.4
const subscriptionImportance = 0.1
const carImportance = 0.1
const locationImportance = 0.35
const mbtiImportance = 0.05
const movingDateImportance = 0.2
const placesofInterestImportance = 0.4

// used to calculate similarity of 2 lists eg: hobbies, places of interest, etc. into number between 0 and 1
function jaccardSimilarity(a: readonly string[], b: readonly string[]): number {

    const setA = new Set(a);
    const setB = new Set(b);

    let intersection = 0;
    for (const item of setA) {
        if (setB.has(item)) intersection++;
    }

    const union = setA.size + setB.size - intersection;
    if (union === 0)
        return 0;
    return Math.sqrt(intersection / union); // using square root to soften for short lists
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
    // complementarity:


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

    return compatibility;
}

export function createGraph() {

}