import {User} from './objects.js'

export default function complementarity(Group: User[]) {
    //CONTRIBUTIONS:
        //for each skill:
            //capacity_s(Group) = Σ (level_i × willingness_i)

            //COVERAGE:
            //c_i = contributions
            // C_s = Σ c_i

            //DOMINCANCE: where one person shares everything
            // maxShare = max(c_i) / (C_s + ε)

            // score_skill = C_s × (1 - maxShare)

        //for each subscription:
            //capacity_s(Group) = Σ (level_i × willingness_i)
            //COVERAGE:
            //c_i = contributions
            // C_s = Σ c_i

            //DOMINCANCE: where one person shares everything
            // maxShare = max(c_i) / (C_s + ε)

            // score_subscriptions = C_s × (1 - maxShare)

        // groupSkillComplementarity =
        // Σ (score_skill × weight_s) / Σ weight_s

        // groupSubscriptionComplementarity =
        // Σ (score_subsription × weight_s) / Σ weight_s
}

// add a value to normalize big group score being generally lower