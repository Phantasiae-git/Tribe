import mongoose from "mongoose";
export declare const Product: mongoose.Model<{
    pname: string;
    pprice: string;
    pdesc: string;
}, {}, {}, {
    id: string;
}, mongoose.Document<unknown, {}, {
    pname: string;
    pprice: string;
    pdesc: string;
}, {
    id: string;
}, mongoose.DefaultSchemaOptions> & Omit<{
    pname: string;
    pprice: string;
    pdesc: string;
} & {
    _id: mongoose.Types.ObjectId;
} & {
    __v: number;
}, "id"> & {
    id: string;
}, mongoose.Schema<any, mongoose.Model<any, any, any, any, any, any, any>, {}, {}, {}, {}, mongoose.DefaultSchemaOptions, {
    pname: string;
    pprice: string;
    pdesc: string;
}, mongoose.Document<unknown, {}, {
    pname: string;
    pprice: string;
    pdesc: string;
}, {
    id: string;
}, mongoose.ResolveSchemaOptions<mongoose.DefaultSchemaOptions>> & Omit<{
    pname: string;
    pprice: string;
    pdesc: string;
} & {
    _id: mongoose.Types.ObjectId;
} & {
    __v: number;
}, "id"> & {
    id: string;
}, {
    [path: string]: mongoose.SchemaDefinitionProperty<undefined, any, any>;
} | {
    [x: string]: mongoose.SchemaDefinitionProperty<any, any, mongoose.Document<unknown, {}, {
        pname: string;
        pprice: string;
        pdesc: string;
    }, {
        id: string;
    }, mongoose.ResolveSchemaOptions<mongoose.DefaultSchemaOptions>> & Omit<{
        pname: string;
        pprice: string;
        pdesc: string;
    } & {
        _id: mongoose.Types.ObjectId;
    } & {
        __v: number;
    }, "id"> & {
        id: string;
    }> | undefined;
}, {
    pname: string;
    pprice: string;
    pdesc: string;
} & {
    _id: mongoose.Types.ObjectId;
} & {
    __v: number;
}>, {
    pname: string;
    pprice: string;
    pdesc: string;
} & {
    _id: mongoose.Types.ObjectId;
} & {
    __v: number;
}>;
//# sourceMappingURL=product.d.ts.map