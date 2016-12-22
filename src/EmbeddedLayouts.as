/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */
package
{
    public class EmbeddedLayouts
    {
        [Embed(source="layouts/register.json", mimeType="application/octet-stream")]
        public static const REGISTER:Class;

        [Embed(source="layouts/record.json", mimeType="application/octet-stream")]
        public static const RECORD:Class;
    }
}
