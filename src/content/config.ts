import { defineCollection, z } from 'astro:content';

const digestCollection = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    date: z.date(),
    tags: z.array(z.string()).optional(),
    summary: z.string().optional(),
  }),
});

export const collections = {
  digest: digestCollection,
};
