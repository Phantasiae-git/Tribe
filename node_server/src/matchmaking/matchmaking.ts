import location_score from './location.js'

// undefined: not available
// 0.5: has but limited
// 1: fully available
type Level = undefined | number;

type LocationPreference = {
    centers: { lon: number, lat: number }
    sigmaKm: number
    weight?: number // importance of location to live
}

type Locations = [LocationPreference]

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
    age: number
    username: string | null
    name: string | null
    id: number
    occupation: string
    student: boolean
    gender: string
    mbti: string
    placesofInterest: string[] // gym, library, etc 
    intendedMovingLocations: Locations
    intendedMovingDate: number | string // not sure yet should be from 0 to 3 of how soon or something similar
    dailyCommuteAreas: Locations
    currentLocation: [lon: number, lat: number]
    incomeLevel: number // from 0 to 5 or something similar
    drivingLicense: boolean
    ownsCar: boolean
    smokes: boolean
    animals: Animals
    subscriptions: Subscriptions
    skills: Skills

}

export default function matchmaking() {
    let location: number = location_score(); // number from 0 to 1
}