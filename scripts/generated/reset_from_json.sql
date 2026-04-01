-- Generated from src/main/resources/json/Authors - final.json and Books - final.json
-- Usage: psql -U postgres -d book_recommendation_system -f scripts/generated/reset_from_json.sql
BEGIN;

TRUNCATE TABLE public.user_book_rate, public.user_book_category, public.user_reading_info, public.book, public.author RESTART IDENTITY CASCADE;

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Adam Wisniewski-Snerg', 'Adam Wisniewski-Snerg was a Polish science fiction author. He was born in Prock, Poland. Although unpopular during his life, after his suicide he became recognized as one of the most significant authors of Polish SF', DATE '1937-01-01', DATE '1937-01-01', 'Poland', 58, 'MALE', 'https://terytoria.com.pl/img/c/10239.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Dave Eggers', 'Dave Eggers is an American writer, editor, and publisher. He wrote the best-selling memoir A Heartbreaking Work of Staggering Genius. Eggers is also the founder of Timothy McSweeney''s Quarterly Concern, a literary journal; a co-founder of the literacy project 826 Valencia and the human rights nonprofit Voice of Witness; and the founder of ScholarMatch, a program that matches donors with students needing funds for college tuition. His writing has appeared in several magazines.', DATE '1970-03-12', NULL, 'Boston', 52, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Dave_Eggers_%2811483%29.jpg/330px-Dave_Eggers_%2811483%29.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Kurt Vonnegut', 'Kurt Vonnegut Jr. was an American writer known for his satirical and darkly humorous novels. In a career spanning over 50 years, he published fourteen novels, three short-story collections, five plays, and five nonfiction works; further collections have been published after his death.', DATE '1922-11-11', DATE '2007-04-11', 'Indianapolis', 84, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Kurt_Vonnegut_1972.jpg/330px-Kurt_Vonnegut_1972.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('J. O. Morgan', 'John Pierpont Morgan Sr. was an American financier and investment banker who dominated corporate finance on Wall Street throughout the Gilded Age. As the head of the banking firm that ultimately became known as J.P. Morgan and Co., he was the driving force behind the wave of industrial consolidation in the United States spanning the late 19th and early 20th centuries.', DATE '1837-04-17', DATE '1913-03-31', 'Roma', 75, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/JohnPierpontMorgan.png/330px-JohnPierpontMorgan.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Theo Clare', 'Beatrice Clare Dunkel was a British author. Earlier in her life she worked as an actress and model under the name Candy Davis. She went on to write novels as Mo Hayder. One forthcoming book, The Book of Sand, will be published in 2022 under the name Theo Clare. She won an Edgar Award in 2012. Her best known work was Birdman', DATE '1962-01-02', DATE '2021-07-27', 'England', 59, 'FEMALE', 'https://upload.wikimedia.org/wikipedia/en/c/c2/Author_Mo_Hayder.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('H. G. Wells', 'Herbert George Wells was an English writer. Prolific in many genres, he wrote more than fifty novels and dozens of short stories. His non-fiction output included works of social commentary, politics, history, popular science, satire, biography and autobiography. Wells is now best remembered for his science fiction novels and has been called the ''father of science fiction.''', DATE '1866-09-21', DATE '1946-08-13', 'England', 79, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/H.G._Wells_by_Beresford.jpg/330px-H.G._Wells_by_Beresford.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Tom Fletcher', 'Tom Fletcher is a number-one bestseller and one of the UK''s most popular children''s authors.', DATE '1985-07-17', NULL, 'United kingdom', 37, 'MALE', 'https://m.media-amazon.com/images/S/amzn-author-media-prod/k731qg1svfggps10hvbot0bfb2._SX450_.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Mur Lafferty', 'Mur Lafferty is an American podcaster and writer based in Durham, North Carolina. She was the editor and host of Escape Pod from 2010, when she took over from Steve Eley, until 2012, when she was replaced by Norm Sherman. She is also the host and creator of the podcast I Should Be Writing. Until July 2007, she was host and co-editor of Pseudopod. She was the Editor-in-Chief of the Escape Artists short fiction magazine Mothership Zeta until it went on hiatus in 2016.', DATE '1973-07-25', NULL, 'Durham', 49, 'FEMALE', 'https://upload.wikimedia.org/wikipedia/commons/2/27/Mur_lafferty_headshot.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Una McCormack', 'Una McCormack (born 13 January 1972) is a British-Irish academic, scriptwriter and novelist. She is the author of The Baba Yaga (2015) and The Star of the Sea (2016), two books in the Weird Space series from UK science fiction publisher Abaddon Books.', DATE '1972-01-13', NULL, 'Merseyside', 50, 'FEMALE', 'https://upload.wikimedia.org/wikipedia/commons/e/ec/Una_McCormack.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Alexis Henderson', 'Alexis Henderson is a speculative fiction writer with a penchant for dark fantasy, witchcraft, and cosmic horror. She grew up in one of America''s most haunted cities, Savannah, Georgia, which instilled in her a life-long love of ghost stories. When she doesn''t have her nose buried in a book, you can find her painting or watching horror movies with her feline familiar. Currently, Alexis resides in the sun-soaked marshland of Charleston, South Carolina.', DATE '1983-09-21', NULL, 'United States', 39, 'FEMALE', 'https://images.gr-assets.com/authors/1608310330p5/16850185.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Francine Toon', 'Toon was born in Canterbury, England, in 1986, and moved to the Scottish Highlands, near Dornoch, at the age of nine after living in England and Portugal. After two years the family moved to St Andrews on the coast of Fife, but the northern wilds have haunted her ever since, and form the backdrop to her debut novel She lives in London and works in publishing: as of 2020 she was an editor at Sceptre', DATE '1986-05-14', NULL, 'Canterbury', 36, 'FEMALE', 'https://static.wixstatic.com/media/19d453_ade3eec758b344ceb1bdb734e5fa1c60~mv2_d_2448_3264_s_4_2.jpg/v1/fill/w_271,h_355,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Francine%20Toon%20author%20photo%201_JPG.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Lynne Truss', 'Lynne Truss is an English author, journalist, novelist, and radio broadcaster and dramatist. She is arguably best known for her championing of correctness and aesthetics in the English language, which is the subject of her popular and widely discussed 2003 book, Eats, Shoots & Leaves: The Zero Tolerance Approach to Punctuation. The book was inspired by a BBC Radio 4 show about punctuation, Cutting a Dash, which she presented.', DATE '1955-03-31', NULL, 'Kingston upon Thames', 67, 'FEMALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Lynne_Truss%2C_author_%2815906630064%29.jpg/330px-Lynne_Truss%2C_author_%2815906630064%29.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('C. J. Tudor', 'C.J. Tudor is a British author whose books include The Chalk Man and The Hiding Place (The Taking of Annie Thorne). She was born in Salisbury, England but grew up in Nottingham, where she still lives.', DATE '1984-11-04', NULL, 'Salisbury', 38, 'FEMALE', 'https://images.gr-assets.com/authors/1512059556p5/15754327.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Susan Hill', 'Dame Susan Hill, Lady Wells, DBE (born 5 February 1942) is an English author of fiction and non-fiction works. Her novels include The Woman in Black, The Mist in the Mirror, and I''m the King of the Castle, for which she received the Somerset Maugham Award in 1971.', DATE '1942-02-05', NULL, 'Scarborough', 80, 'FEMALE', 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQPco9BaYEXN2wyT5EXCc9TkDTQbN9OLKEER2vxk0_A1jZM9ji1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Mary Shelley', 'Mary Wollstonecraft Shelley was an English novelist who wrote the Gothic novel Frankenstein; or, The Modern Prometheus (1818), which is considered an early example of science fiction. She also edited and promoted the works of her husband, the Romantic poet and philosopher Percy Bysshe Shelley. Her father was the political philosopher William Godwin and her mother was the philosopher and women''s rights advocate Mary Wollstonecraft.', DATE '1797-08-30', DATE '1851-02-01', 'United kingdom', 53, 'FEMALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Mary_Wollstonecraft_Shelley_Rothwell.tif/lossy-page1-375px-Mary_Wollstonecraft_Shelley_Rothwell.tif.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Edgar Allan Poe', 'Edgar Allan Poe was an American writer, poet, editor, and literary critic. Poe is best known for his poetry and short stories, particularly his tales of mystery and the macabre. He is widely regarded as a central figure of Romanticism in the United States, and of American literature. Poe was one of the country''s earliest practitioners of the short story, and considered to be the inventor of the detective fiction genre, as well as a significant contributor to the emerging genre of science fiction. Poe is the first well-known American writer to earn a living through writing alone, resulting in a financially difficult life and career.', DATE '1809-01-19', DATE '1849-10-07', 'Boston', 40, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/Edgar_Allan_Poe%2C_circa_1849%2C_restored%2C_squared_off.jpg/330px-Edgar_Allan_Poe%2C_circa_1849%2C_restored%2C_squared_off.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('E F Benson', 'Edward Frederic Benson OBE was an English novelist, biographer, memoirist, archaeologist and short story writer.', DATE '1867-07-24', DATE '1940-02-29', 'Berkshire', 72, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/E._F._Benson.jpg/330px-E._F._Benson.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('colson whitehead', 'Arch Colson Chipp Whitehead is an American novelist. He is the author of eight novels, including his 1999 debut work The Intuitionist; The Underground Railroad (2016), for which he won the 2016 National Book Award for Fiction and the 2017 Pulitzer Prize for Fiction; he won the Pulitzer Prize for Fiction again in 2020 for The Nickel Boys. He has also published two books of non-fiction. In 2002, he received a MacArthur Genius Grant.', DATE '1969-11-06', NULL, 'New York', 53, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Colson_whitehead_2014.jpg/330px-Colson_whitehead_2014.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Shirley Jackson', 'Shirley Hardie Jackson was an American writer known primarily for her works of horror and mystery. Over the duration of her writing career, which spanned over two decades, she composed six novels, two memoirs, and more than 200 short stories.', DATE '1916-12-14', DATE '1965-08-08', 'San Francisco', 48, 'FEMALE', 'https://upload.wikimedia.org/wikipedia/en/4/43/ShirleyJack.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Bram Stoker', 'Abraham Stoker was an Irish author who is celebrated for his 1897 Gothic horror novel Dracula. During his lifetime, he was better known as the personal assistant of actor Sir Henry Irving and business manager of the Lyceum Theatre, which Irving owned. In his early years, Stoker worked as a theatre critic for an Irish newspaper, and wrote stories as well as commentaries.', DATE '1847-11-08', DATE '1912-03-20', 'Ireland', 64, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Bram_Stoker_1906.jpg/330px-Bram_Stoker_1906.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Gabriel Garcia Marquez', 'Gabriel Jos de la Concordia Garca Mrquez     was a Colombian novelist, short-story writer, screenwriter, and journalist, known affectionately as Gabo. throughout Latin America. Considered one of the most significant authors of the 20th century, particularly in the Spanish language, he was awarded the 1972 Neustadt International Prize for Literature and the 1982 Nobel Prize in Literature.', DATE '1927-03-06', DATE '2014-04-17', 'Spanish', 87, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Gabriel_Garcia_Marquez.jpg/330px-Gabriel_Garcia_Marquez.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Leo Tolstoy', 'Count Lev Nikolayevich Tolstoy, usually referred to in English as Leo Tolstoy, was a Russian writer who is regarded as one of the greatest authors of all time. He received nominations for the Nobel Prize in Literature every year from 1902 to 1906 and for the Nobel Peace Prize in 1901, 1902, and 1909; the fact that he never won is a major controversy.', DATE '1828-09-09', DATE '1910-11-07', 'Russian Empire', 82, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/L.N.Tolstoy_Prokudin-Gorsky.jpg/330px-L.N.Tolstoy_Prokudin-Gorsky.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Harper Lee', 'Nelle Harper Lee was an American novelist best known for her 1960 novel To Kill a Mockingbird. It won the 1961 Pulitzer Prize and has become a classic of modern American literature. Lee has received numerous accolades and honorary degrees, including the Presidential Medal of Freedom in 2007 which was awarded for her contribution to literature.', DATE '1926-04-28', DATE '2016-02-19', 'United States', 89, 'FEMALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Photo_portrait_of_Harper_Lee_%28To_Kill_a_Mockingbird_dust_jacket%2C_1960%29.jpg/330px-Photo_portrait_of_Harper_Lee_%28To_Kill_a_Mockingbird_dust_jacket%2C_1960%29.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Anthony Burgess', 'John Anthony Burgess Wilson, who published under the name Anthony Burgess, was an English writer and composer.', DATE '1917-02-25', DATE '1993-11-22', 'England', 76, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/2/21/Burgess1.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Sadeq Hedayat', 'Sadegh Hedayat was an Iranian writer and translator. Best known for his novel The Blind Owl, he was one of the earliest Iranian writers to adopt literary modernism in their career.', DATE '1903-02-17', DATE '1951-04-09', 'Imperial Iran', 48, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/b/b6/Sadegh_Hedayat_colorized.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Georgette Heyer', 'Georgette Heyer was an English novelist and short-story writer, in both the regency romance and detective fiction genres. Her writing career began in 1921, when she turned a story for her younger brother into the novel The Black Moth.', DATE '1902-08-16', DATE '1974-07-04', 'England', 72, 'FEMALE', 'https://upload.wikimedia.org/wikipedia/en/1/15/Georgette_Heyer.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Oscar Wilde', 'Oscar Fingal O''Flahertie Wills Wilde was an Irish poet and playwright. After writing in different forms throughout the 1880s, he became one of the most popular playwrights in London in the early 1890s. He is best remembered for his epigrams and plays, his novel The Picture of Dorian Gray, and the circumstances of his criminal conviction for gross indecency for consensual homosexual acts in ''one of the first celebrity trials'', imprisonment, and early death from meningitis at age 46.', DATE '1854-10-16', DATE '1900-11-30', 'Ireland', 46, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Oscar_Wilde_3g07095u-adjust.jpg/330px-Oscar_Wilde_3g07095u-adjust.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Harold Sonny Ladoo', 'Harold Sonny Ladoo was a Caribbean novelist, who was the author of two books documenting the struggles of living in poverty in the Hindu communities of Trinidad and Tobago. He moved to Canada in 1968 and was mysteriously murdered while on a visit to Trinidad in 1973.', DATE '1945-04-07', DATE '1973-08-17', 'Trinidad', 38, 'MALE', 'https://library.torontomu.ca/asianheritage/files/2012/06/ladoo.gif', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Kahlil Gibran', 'Gibran Khalil Gibran was a Lebanese-American writer, poet and visual artist, also considered a philosopher although he himself rejected the title. He is best known as the author of The Prophet, which was first published in the United States in 1923 and has since become one of the best-selling books of all time, having been translated into more than 100 languages.', DATE '1883-01-06', DATE '1931-04-10', 'Lebanon', 48, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/3/34/Kahlil_Gibran_1913.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Clive Cussler', 'Clive Eric Cussler was an American adventure novelist and underwater explorer. His thriller novels, many featuring the character Dirk Pitt, have reached The New York Times fiction best-seller list more than 20 times. Cussler was the founder and chairman of the National Underwater and Marine Agency (NUMA), which has discovered more than 60 shipwreck sites and numerous other notable underwater wrecks. He was the sole author or lead author of more than 80 books.', DATE '1931-07-15', DATE '2020-02-24', 'Arizona', 88, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Clive_Cussler_%282011%29.jpg/375px-Clive_Cussler_%282011%29.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Robert Harris', 'Robert Dennis Harris is a British novelist and former journalist. Although he began his career in journalism and non-fiction, his fame rests upon his works of historical fiction. Beginning with the best-seller Fatherland, Harris focused on events surrounding the Second World War, followed by works set in ancient Rome. His most recent works centre on contemporary history. Harris was educated at Selwyn College, Cambridge, where he was president of the Cambridge Union and editor of the student newspaper Varsity.', DATE '1957-03-07', NULL, 'England', 65, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Robert_Harris01.jpg/330px-Robert_Harris01.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('George Psychoundakis', 'George Psychoundakis BEM was a member of the Greek Resistance on Crete during the Second World War and after the war an author. Following the German invasion, between 1941 and 1945, he served as a despatch runner for the Special Operations Executive (SOE) operations on Crete, as part of the Cretan resistance. During the postwar years he was at first mistakenly imprisoned as a deserter. While in prison he wrote his wartime memoirs, which were published as The Cretan Runner. Later he translated key classical Greek texts into the Cretan dialect.', DATE '1920-11-03', DATE '2006-01-29', 'Greek', 86, 'MALE', 'https://patrickleighfermor.files.wordpress.com/2010/05/george-psychoundakis.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('John Buchan', 'John Buchan, 1st Baron Tweedsmuir GCMG GCVO CH PC DL was a Scottish novelist, historian, and Unionist politician who served as Governor General of Canada, the 15th since Canadian Confederation.', DATE '1875-08-26', DATE '1940-02-11', 'Canada', 35, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Lord_tweedsmuiir.jpg/330px-Lord_tweedsmuiir.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Michael Crichton', 'John Michael Crichton was an American author and filmmaker. His books have sold over 200 million copies worldwide, and over a dozen have been adapted into films. His literary works heavily feature technology and are usually within the science fiction, techno-thriller, and medical fiction genres. His novels often explore technology and failures of human interaction with it, especially resulting in catastrophes with biotechnology. Many of his novels have medical or scientific underpinnings, reflecting his medical training and scientific background.', DATE '1942-10-23', DATE '2008-11-04', 'United States', 66, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/MichaelCrichton_2.jpg/330px-MichaelCrichton_2.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Andy Weir', 'Andrew Taylor Weir is an American novelist and former computer programmer. His 2011 novel The Martian was adapted into the 2015 film of the same name directed by Ridley Scott. He received the John W. Campbell Award for Best New Writer in 2016 and his 2021 novel Project Hail Mary is a finalist for the 2022 Hugo Award for Best Novel.', DATE '1972-06-16', NULL, 'California', 50, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/NASA_Journey_to_Mars_and_%E2%80%9CThe_Martian%22_%28201508180048HQ%29.jpg/330px-NASA_Journey_to_Mars_and_%E2%80%9CThe_Martian%22_%28201508180048HQ%29.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Dan Brown', 'Daniel Gerhard Brown (born June 22, 1964) is an American author best known for his thriller novels, including the Robert Langdon novels Angels & Demons (2000), The Da Vinci Code (2003), The Lost Symbol (2009), Inferno (2013), and Origin (2017). His novels are treasure hunts which usually take place over a period of 24 hours. They feature recurring themes of cryptography, art, and conspiracy theories. His books have been translated into 57 languages and, as of 2012, have sold over 200 million copies. Three of them, Angels & Demons, The Da Vinci Code, and Inferno, have been adapted into films.', DATE '1964-06-22', NULL, 'New Hampshire', 58, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8b/Dan_Brown_bookjacket_cropped.jpg/330px-Dan_Brown_bookjacket_cropped.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Marc Cameron', 'Marc Cameron is an American novelist. He is best known for the Jack Ryan series, which is part of the Tom Clancy universe, as well as for the critically acclaimed Jericho Quinn series of action adventure novels.', DATE '1961-07-15', NULL, 'Texas', 61, 'MALE', 'https://marccameronbooks.com/wp-content/uploads/2019/11/M38fd582f01239b50588b0060a16ce4f51573590045445.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Emma Morgan', 'Emma Morgan was born in Guernsey and lives in Liverpool. She studied history at Liverpool University and Theatre at Essex University before deciding to move to Spain, where she taught English for five years. She has also worked as a support worker and for BBC local radio. A Love Story for Bewildered Girls is her first novel.', DATE '1988-08-07', NULL, 'Guernsey', 34, 'FEMALE', 'http://www.collectivetalent.co.uk/uploads/1/8/4/6/18461164/published/img-20170819-132545823-hdr.jpg?1595231037', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Howard Jacobson', 'Howard Eric Jacobson is a British novelist and journalist. He is known for writing comic novels that often revolve around the dilemmas of British Jewish characters. He is a Booker Prize winner.', DATE '1942-08-25', NULL, 'Manchester', 80, 'MALE', 'https://i.guim.co.uk/img/media/3242bc28387bdfe89aed4e9d1bcf3b9fd6bfd16e/462_98_2385_1431/master/2385.jpg?width=620&quality=45&dpr=2&s=none', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Jane Sanderson', 'Sanderson was educated at Kirk Balk School near Barnsley, and at Leicester University. She was a newspaper journalist before joining the BBC, where she was a producer on The World At One, PM, and Woman''s Hour.', DATE '1962-08-17', NULL, 'Barnsley', 60, 'FEMALE', 'https://www.orionbooks.co.uk/wp-content/uploads/2018/07/contributor-jane-sanderson-27.jpg?', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Jojo Moyes', 'Pauline Sara Jo Moyes, known professionally as Jojo Moyes, is an English journalist and, since 2002, an award-winning romance novelist, #1 New York Times best selling author and screenwriter. She is one of only a few authors to have twice won the Romantic Novel of the Year Award by the Romantic Novelists'' Association and her works have been translated into twenty-eight languages and have sold over 40 million copies worldwide.', DATE '1969-08-04', NULL, 'England', 53, 'FEMALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Paris_-_Salon_du_livre_de_Paris_2017_-_Jojo_Moyes_-_001_%28cropped%29.jpg/330px-Paris_-_Salon_du_livre_de_Paris_2017_-_Jojo_Moyes_-_001_%28cropped%29.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Isabelle Broom', 'Isabelle Broom was born in Cambridge nine days before the 1980s began and studied Media Arts in London before joining the ranks at Heat magazine, where she remains the Book Reviews editor. Always happiest when she is off on an adventure, Isabelle now travels all over the world seeking out settings for her novels', DATE '1979-12-21', NULL, 'Cambridge', 43, 'FEMALE', 'https://wp.penguin.co.uk/wp-content/uploads/2022/04/contributor-60.jpg?', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Anne Youngson', 'Anne Youngson worked for many years in senior management in the car industry before embarking on a creative career as a writer. She has supported many charities in governance roles, including Chair of the Writers in Prison Network, which provided residencies in prisons for writers.', DATE '1947-04-12', NULL, 'London', 75, 'FEMALE', 'https://greeneheaton.co.uk/wp-content/uploads/2017/06/Anne-Youngson-440x500.png', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Marian Keyes', 'Marian Keyes is an Irish author and radio presenter. She is principally known for her popular fiction.', DATE '1963-09-10', NULL, 'Limerick', 59, 'FEMALE', 'https://i.guim.co.uk/img/media/2b03e894a9e8ab23556db787d677d2afca72a8ab/0_1929_4920_2951/master/4920.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=3ee93eda7ba83845ba136fa9bf81618b', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Lisa Jewell', 'Lisa Jewell is a British author of popular fiction. Her books include Ralph''s Party, Thirtynothing, After The Party (a sequel to Ralph''s Party), and later Then She Was Gone, The House We Grew Up In and The Girls in the Garden.', DATE '1968-07-19', NULL, 'London', 54, 'FEMALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Lisa_Jewell_Official_Author_Photo.jpg/330px-Lisa_Jewell_Official_Author_Photo.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Roald Dahl', 'Roald Dahl[a] was a British novelist, short-story writer, poet, screenwriter, and wartime fighter ace of Norwegian descent. His books have sold more than 250 million copies worldwide. Dahl has been called ''one of the greatest storytellers for children of the 20th century''.', DATE '1916-09-13', DATE '1990-11-23', 'Cardiff', 74, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Roald_Dahl.jpg/330px-Roald_Dahl.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Adam Kay', 'Adam Richard Kay is a British comedy writer, author, comedian and former doctor. His television writing credits include Crims, Mrs. Brown''s Boys and Mitchell and Webb. He is best known as author of the number-one bestselling book This Is Going to Hurt.', DATE '1980-06-12', NULL, 'Brighton', 42, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8b/Adam_Kay_20171207_02.jpg/330px-Adam_Kay_20171207_02.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Leisa Stewart-Sharpe', 'Leisa Stewart-Sharpe is a trained journalist turned children''s book author, who writes stunning children''s non-fiction and picture books. Her Australian childhood inspired her love for the natural world - and the stories of its strange and wonderful creatures. Her bestselling first non-fiction book, Blue Planet II, has been translated into several languages around the world.', DATE '1975-01-27', NULL, 'England', 47, 'FEMALE', 'https://pbs.twimg.com/profile_images/837338424889786373/kdUhnZx-_400x400.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Jacqueline Wilson', 'Dame Jacqueline Wilson DBE FRSL (ne Aitken; born 17 December 1945) is an English novelist known for her popular children''s literature. Her novels have been notable for featuring realistic topics such as adoption and divorce without alienating her large readership. Since her debut novel in 1969, Wilson has written over 100 books.', DATE '1945-12-17', NULL, 'England', 76, 'FEMALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Jacqueline_Wilson.JPG/330px-Jacqueline_Wilson.JPG', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Dick King-Smith', 'Ronald Gordon King-Smith OBE Hon.MEd was an English writer of children''s books, primarily using the pen name Dick King-Smith. He is best known for The Sheep-Pig (1983, Babe the Gallant Pig US title). It was adapted as the movie Babe (1995) and translations have been published in fifteen languages. He was awarded an Honorary Master of Education degree by the University of the West of England in 1999 and appointed Officer of the Order of the British Empire (OBE) in the 2010 New Year Honours.', DATE '1922-03-27', DATE '2011-01-04', 'Bitton', 88, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Dick_King-Smith.jpg/330px-Dick_King-Smith.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Beatrix Potter', 'Helen Beatrix Potter was an English writer, illustrator, natural scientist, and conservationist. She is best known for her children''s books featuring animals, such as The Tale of Peter Rabbit, which was her first published work in 1902. Her books, including 23 Tales, have sold more than 250 million copies. Potter was also a pioneer of merchandising-in 1903, Peter Rabbit was the first fictional character to be made into a patented stuffed toy, making him the oldest licensed character.', DATE '1866-07-28', DATE '1943-12-22', 'London', 77, 'FEMALE', 'https://upload.wikimedia.org/wikipedia/commons/9/93/Beatrix_Potter_by_King_cropped.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Kim Hillyard', 'After completing a degree in Drama at the University of Exeter, Kim Hillyard spent nine years working as a music journalist for various publications, including NME, Time Out and the BBC. She has also worked as a drama and arts facilitator, delivering assemblies, storytelling and workshops in schools, bookshops and community spaces on everything from phonics to creative writing. Kim''s debut picture book, Mabel and the Mountain, won the 2020 Sainsbury''s Children''s Book Award and her second title (Ned and the Great Garden Hamster Race) was released in January 2021.', DATE '1988-09-13', NULL, 'United kingdom', 34, 'FEMALE', 'https://pbs.twimg.com/profile_images/1269736455015927808/ZjyTJiJg_400x400.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Sharna Jackson', 'Sharna Jackson is a British writer of children''s fiction. She is the author of a mystery series, aimed at middle-grade readers, featuring Nik and Norva, a pair of black sisters, who solve crimes on an estate, the Tri Estate, in South London.[2] Jackson is also an influential curator in the arts, including working with Tate, Victoria and Albert Museum and Design museum in London, and working as artistic director for Site Gallery in Sheffield from July 2018 to November 2020, engaging children in developing digital initiatives in the arts.', DATE '1978-11-08', NULL, 'New York', 44, 'FEMALE', 'https://images.squarespace-cdn.com/content/v1/5cd9631a4d546e16d410f256/1557766189873-DJQJPGQMPLNDU488FFDQ/Ensemble-2019-JPEGs-1.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Ta-Nehisi Coates', 'Ta-Nehisi Paul Coates is an American author and journalist. He gained a wide readership during his time as national correspondent at The Atlantic, where he wrote about cultural, social, and political issues, particularly regarding African Americans and white supremacy. Coates has worked for The Village Voice, Washington City Paper, and TIME. He has contributed to The New York Times Magazine, The Washington Post, The Washington Monthly, O, and other publications.', DATE '1975-09-30', NULL, 'Baltimore', 47, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Ta-Nehisi_Coates.jpg/330px-Ta-Nehisi_Coates.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Christopher Harding', 'Christopher Harding is a cultural historian of modern India and Japan, lecturer in Asian history at the University of Edinburgh, broadcaster and journalist. His series on culture and mental health, The Borders of Sanity, was broadcast on BBC Radio 4 and the BBC World Service in 2016.', DATE '1978-07-17', NULL, 'England', 44, 'MALE', 'https://t3.gstatic.com/images?q=tbn:ANd9GcREtATehkcJmZZ4kXNCnje-ctkozrGE_IJzxWiMGrBzbnipI7vI', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Piers Brendon', 'Piers Brendon FRSL is a British historian and writer, known for historical and biographical works. He was educated at Shrewsbury School and Magdalene College, Cambridge, where he read history. He received a Ph.D. degree for his thesis, Hurrell Froude and the Oxford Movement, which was published, with much modification, in 1974.', DATE '1940-12-21', NULL, 'Stratton', 81, 'MALE', 'https://www.chu.cam.ac.uk/wp-content/uploads/2021/12/Piers-Brendon.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Ian Blatchford', 'Sir Ian Craig Blatchford, FSA is the director of the Science Museum Group, which oversees the Science Museum in London, England and other related museums. He was previously deputy director of the Victoria and Albert Museum, opposite the Science Museum on Exhibition Road in South Kensington, southwest London.', DATE '1965-08-17', NULL, 'Ireland', 57, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Ian_Blatchford_-_Kolkata_2012-03-20_9312_Cropped.JPG/270px-Ian_Blatchford_-_Kolkata_2012-03-20_9312_Cropped.JPG', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('David Abulafia', 'David Abulafia FSA FRHistS FBA is an English historian with a particular interest in Italy, Spain and the rest of the Mediterranean during the Middle Ages and Renaissance. He spent most of his career at the University of Cambridge, rising to become a professor at the age of 50.', DATE '1949-12-12', NULL, 'Twickenham', 72, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/David_Abulafia_%28cropped%29.jpg/330px-David_Abulafia_%28cropped%29.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Horatio Clare', 'Horatio Clare (born 1973) is an author known for travel, memoir, nature and children''s books. He worked at the BBC as a producer on Front Row (BBC Radio 4), Night Waves and The Verb (BBC Radio 3).', DATE '1973-11-08', NULL, 'London', 49, 'MALE', 'https://media.vanityfair.com/photos/5bfd1613296c752cecdfdf5c/1:1/w_640,h_640,c_limit/Horatio-Clare-at-Hay-Festival-2017-credit-Paul-Musso.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Sathnam Sanghera', 'Sathnam Sanghera was born to Indian Punjabi parents in Wolverhampton in 1976. His parents had emigrated from India to the UK in 1968. He was raised a Punjabi boy. He attended Wolverhampton Grammar School and graduated from Christ''s College, Cambridge, with a first-class degree in English Language and Literature in 1998.', DATE '1976-09-04', NULL, 'Indian', 46, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Sathnam_Sanghera_for_the_British_Library.jpg/330px-Sathnam_Sanghera_for_the_British_Library.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Adam Higginbotham', 'Adam Higginbotham is a British journalist who is the former U.S. correspondent for The Sunday Telegraph Magazine and former editor-in-chief of The Face. He has also served as a contributing writer for The New Yorker, Wired, and The New York Times.', DATE '1968-10-07', NULL, 'Somerset', 54, 'MALE', 'https://www.chicagotribune.com/resizer/zrCxzK_AbvKxp1F5xRTx0rXdFSk=/960x540/filters:quality(80)/arc-goldfish-tronc-thumbnails.s3.amazonaws.com/04-14-2019/t_09c34337a28b4110aefe9660570c1fc2_name_la_books_video_playlist_ah_20190414_scaled.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('David Montenegro', 'Wing Commander David Montenegro OBE MA RAF, known as Monty, commands a team of Royal Air Force regular and reserve personnel, working alongside civil service colleagues, who deliver a precise, dynamic and world-renowned ''soft'' power capability, in support of national interests, at home and across the globe. ', DATE '1975-06-11', NULL, 'England', 47, 'MALE', 'https://www.raf.mod.uk/sites/raf-beta/assets/Image/Red%20Arrows/SCA-Official-20200331-292-041.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('P. G. Wodehouse', 'Sir Pelham Grenville Wodehouse was an English author and one of the most widely read humorists of the 20th century. His creations include the feather-brained Bertie Wooster and his sagacious valet, Jeeves; the immaculate and loquacious Psmith; Lord Emsworth and the Blandings Castle set; the Oldest Member, with stories about golf; and Mr Mulliner, with tall tales on subjects ranging from bibulous bishops to megalomaniac movie moguls.', DATE '1881-10-15', DATE '1975-02-14', 'England', 96, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/P.G._Wodehouse%2C_1930.jpg/330px-P.G._Wodehouse%2C_1930.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Zlatan Ibrahimovic', 'Zlatan Ibrahimovi is a Swedish professional footballer who plays as a striker for Serie A club AC Milan and the Sweden national team. Ibrahimovi is renowned for his acrobatic strikes and volleys, powerful long-range shots, and excellent technique and ball control. He is regarded as one of the greatest strikers of all time and is one of the most decorated active footballers in the world, having won 34 trophies in his career. He has scored over 570 career goals, including more than 500 club goals, and has scored in each of the last four decades.', DATE '1981-10-03', NULL, 'Sweden', 41, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Zlatan_Ibrahimovi%C4%87_June_2018.jpg/330px-Zlatan_Ibrahimovi%C4%87_June_2018.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Richard Askwith', 'Richard Askwith is a British journalist and author.He is best-known for the cult 2004 fell running book Feet in the Clouds, which won him the Best New Writer prize at the Sports Book Awards. The book was also shortlisted for the William Hill Sports Book of the Year and the Boardman Tasker Prize for Mountain Literature.', DATE '1960-10-08', NULL, 'England', 62, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/b/bc/Richard_Askwith_2010.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Nicola Adams', 'Nicola Virginia Adams OBE is a British former professional boxer who competed from 2017 to 2019. She retired with an undefeated record and held the WBO female flyweight title in 2019. As an amateur, she became the first female boxer to become an Olympic champion after winning gold at London 2012, and the first double Olympic champion following a second gold medal at Rio 2016, both in the flyweight division.', DATE '1982-10-26', NULL, 'West Yorkshire', 40, 'FEMALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Nicola_Adams_-_Our_Greatest_Team_Parade.jpg/330px-Nicola_Adams_-_Our_Greatest_Team_Parade.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Ed Warner', 'Edward L. Warner was an American college basketball player. He was one of the stars of the 1949-50 CCNY Beavers men''s basketball team, the only team to win both the NCAA tournament and the National Invitation Tournament (NIT) in the same year. He was also a central figure in the point shaving scandal that came to light in the aftermath of that season.', DATE '1929-07-05', DATE '2002-09-07', 'New York', 73, 'MALE', 'https://www.thedraftreview.com/images/honorabledraftee/ed-warner.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('John D. Barrow', 'John David Barrow FRS was an English cosmologist, theoretical physicist, and mathematician. He served as Gresham Professor of Geometry at Gresham College from 2008 to 2011. Barrow was also a writer of popular science and an amateur playwright.', DATE '1952-11-29', DATE '2020-09-26', 'London', 67, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/John_Barrow.jpg/330px-John_Barrow.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Bear Grylls', 'Edward Michael ''Bear'' Grylls OBE (born 7 June 1974) is a British adventurer, writer, television presenter and businessman. He first drew attention after embarking on a number of adventures, and then became widely known for his television series Man vs. Wild (2006-2011).', DATE '1974-06-07', NULL, 'London', 48, 'MALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/Coventry_Scouts_groups_have_a_visit_from_Bear_Grylls.jpg/330px-Coventry_Scouts_groups_have_a_visit_from_Bear_Grylls.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Billie Jean King', 'Billie Jean King is an American former world No. 1 tennis player. King won 39 major titles: 12 in singles, 16 in women''s doubles, and 11 in mixed doubles. King was a member of the victorious United States team in seven Federation Cups and nine Wightman Cups. For three years, she was the U.S. captain in the Federation Cup.', DATE '1943-11-23', NULL, 'California', 78, 'FEMALE', 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/BJK_headshot_2011_5x7_300dpi.jpg/330px-BJK_headshot_2011_5x7_300dpi.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Lee Newbery', 'Lee Newbery lives with his husband, son and two dogs in a seaside town in West Wales. By day, he helps vulnerable people look for jobs and gain new skills, and by night, he sits down at his laptop to write.', DATE '1977-05-08', NULL, 'Poland', 45, 'MALE', 'https://storage.googleapis.com/lr-assets/kids/authors/1645700633-lee-newbery--the-last-firefox--credit-desiree-adams-(sq).jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.author
(name, description, birthdate, deathdate, country, age, gender, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ('Chris Smith', 'Chris Smith has wanted to be an author ever since he was eight and won a competition by writing a story about a baby dinosaur who loved biscuits. That story is soon to be brought to life as a blockbuster Hollywood movie. Not really, he made that part up.', DATE '1974-12-15', NULL, 'Ireland', 48, 'MALE', 'https://pbs.twimg.com/profile_images/1317715382556368896/S8PrS9RY_400x400.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Adam Wisniewski-Snerg'), (SELECT id FROM public.book_category WHERE name = 'Science Fiction'), 'Robot', 4.99, 0, 0, 336, 677, DATE '2021-06-03', 'As the Kremlin orders troops to mass on the Ukrainian border, a Russian plane carrying nukes disappears mid-flight. For US President Jack Ryan this means attempting to defuse a war on Europe''s flanks before it engulfs the whole continent.', 'https://cdn.penguin.co.uk/dam-assets/books/9780141995359/9780141995359-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Dave Eggers'), (SELECT id FROM public.book_category WHERE name = 'Science Fiction'), 'The Every', 5.99, 0, 0, 608, 1176, DATE '2021-11-16', 'When the world''s largest search engine / social media company merges with the planet''s dominant e-commerce site, it creates the richest and most dangerous-and, oddly enough, most beloved-monopoly ever known: The Every.', 'https://cdn.penguin.co.uk/dam-assets/books/9780241535509/9780241535509-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Kurt Vonnegut'), (SELECT id FROM public.book_category WHERE name = 'Science Fiction'), 'Player Piano', 9.99, 0, 0, 352, 604, DATE '2021-11-16', 'Player Piano is the debut novel from one of history''s most innovative authors, published on Vonnegut''s 100th birthday.', 'https://cdn.penguin.co.uk/dam-assets/books/9781473582392/9781473582392-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'J. O. Morgan'), (SELECT id FROM public.book_category WHERE name = 'Science Fiction'), 'Appliance', 16.99, 0, 0, 208, 476, DATE '2022-05-19', 'Are they paying you extra for this? You''d better be getting something. For the inconvenience, I mean. Here for the whole weekend is what they said. What if we''d had guests? They never asked. And in any case what are the dangers? Being tested like lab rats, we are. Did they even try to provide any assurance it was all perfectly', 'https://cdn.penguin.co.uk/dam-assets/books/9781787333888/9781787333888-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Theo Clare'), (SELECT id FROM public.book_category WHERE name = 'Science Fiction'), 'The Book of Sand', 9.99, 0, 0, 608, 1116, DATE '2022-08-04', 'Outlines of several once-busy cities shimmer on the horizon. Now empty of inhabitants, their buildings lie in ruins. In the distance a group of people - a family - walk towards us.', 'https://cdn.penguin.co.uk/dam-assets/books/9781529158014/9781529158014-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'H. G. Wells'), (SELECT id FROM public.book_category WHERE name = 'Science Fiction'), 'The War of the Worlds', 6.99, 0, 0, 240, 474, DATE '2005-03-31', 'The first modern depiction of extra-terrestrials attacking the earth, The War of the Worlds remains one of the most influential of all science-fiction works. It shows the whole of human civilization under threat, as terrifying, tentacled Martians land in England, build gigantic killing machines, destroy all in their path with black gas and burning rays and feast on the warm blood of trapped, still-living human prey. The forces of the Earth, however, may prove harder to beat than they at first appear.', 'https://cdn.penguin.co.uk/dam-assets/books/9780141441030/9780141441030-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'H. G. Wells'), (SELECT id FROM public.book_category WHERE name = 'Science Fiction'), 'The Invisible Man', 6.99, 0, 0, 192, 300, DATE '2017-01-05', 'A cautionary horror story about the dangers of greed, isolation and a science without ethics, from the father of science fiction.', 'https://cdn.penguin.co.uk/dam-assets/books/9781784872090/9781784872090-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Tom Fletcher'), (SELECT id FROM public.book_category WHERE name = 'Science Fiction'), 'Eve of Man', 8.99, 0, 0, 432, 300, DATE '2020-01-23', 'Eve lives alone in the Tower under the strict gaze of the Mothers. She is prized and protected, because she is the last girl on earth.', 'https://cdn.penguin.co.uk/dam-assets/books/9780718184124/9780718184124-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Mur Lafferty'), (SELECT id FROM public.book_category WHERE name = 'Science Fiction'), 'A Star Wars Story', 8.99, 0, 0, 368, 300, DATE '2019-05-02', 'Though Han Solo has thrilled Star Wars fans for decades, the notorious wisecracking scoundrel was chasing adventure and dodging trouble long before he walked into the cantina at Mos Eisley spaceport.', 'https://cdn.penguin.co.uk/dam-assets/books/9781787462076/9781787462076-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Una McCormack'), (SELECT id FROM public.book_category WHERE name = 'Science Fiction'), 'Doctor Who: Molten Heart', 10.99, 0, 0, 208, 300, DATE '2018-11-08', 'Deep below the surface of the planet Adamantine lies a crystalline wonder world of lava seas and volcanic islands, home to living rock-people.', 'https://cdn.penguin.co.uk/dam-assets/books/9781785943638/9781785943638-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Alexis Henderson'), (SELECT id FROM public.book_category WHERE name = 'Horror'), 'The Year of the Witching', 8.99, 0, 0, 368, 300, DATE '2021-09-30', 'The Handmaid''s Tale meets The Village in this stunning feminist debut . . . Shortlisted for the Good Reads Choice Awards 2020 for Best Debut Novel and Best Horror Novel . . .', 'https://cdn.penguin.co.uk/dam-assets/books/9780552176682/9780552176682-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Francine Toon'), (SELECT id FROM public.book_category WHERE name = 'Horror'), 'Pine', 8.99, 0, 0, 336, 300, DATE '2020-10-01', 'Shortlisted for Bloody Scotland''s Scottish Crime Debut of the Year 2020', 'https://cdn.penguin.co.uk/dam-assets/books/9781784164829/9781784164829-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Lynne Truss'), (SELECT id FROM public.book_category WHERE name = 'Horror'), 'Cat out of Hell', 12.99, 0, 0, 256, 300, DATE '2014-10-09', 'By acclaimed storyteller Lynne Truss, authorName of the bestselling Eats, Shoots and Leaves, the mesmerizing tale of a cat with nine lives, and a relationship as ancient as time itself and just as powerful.', 'https://cdn.penguin.co.uk/dam-assets/books/9780099585343/9780099585343-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'C. J. Tudor'), (SELECT id FROM public.book_category WHERE name = 'Horror'), 'The Chalk Man', 9.99, 0, 0, 368, 300, DATE '2018-08-23', '''IF YOU LIKE MY STUFF, YOU''LL LIKE THIS'' STEPHEN KING''WONDERFULLY CREEPY - LIKE A COLD BLADE ON THE BACK OF YOUR NECK'' LEE CHILD...', 'https://cdn.penguin.co.uk/dam-assets/books/9781405930956/9781405930956-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Susan Hill'), (SELECT id FROM public.book_category WHERE name = 'Horror'), 'The Woman in Black', 4.99, 0, 0, 240, 300, DATE '2015-02-05', 'Heartstoppingly chilling'' Daily Express. Read the truly terrifying classic English ghost story behind the play.', 'https://cdn.penguin.co.uk/dam-assets/books/9781473521025/9781473521025-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Mary Shelley'), (SELECT id FROM public.book_category WHERE name = 'Horror'), 'Frankenstein', 5.99, 0, 0, 288, 300, DATE '2011-02-03', 'Victor Frankenstein has made a terrible mistake. In his desperate pursuit to create life, he has created a monster', 'https://cdn.penguin.co.uk/dam-assets/books/9780141967127/9780141967127-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Edgar Allan Poe'), (SELECT id FROM public.book_category WHERE name = 'Horror'), 'The Murders in the Rue Morgue', 6.99, 0, 0, 169, 152, DATE '2009-01-01', 'Edgar Allan Poe invented detective fiction with these three mesmerising stories of a young eccentric named C. Auguste Dupin: ''The Murders in the Rue Morgue'', ''The Mystery of Marie Rogt'' and ''The Purloined Letter''.', 'https://cdn.penguin.co.uk/dam-assets/books/9780099529583/9780099529583-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'E F Benson'), (SELECT id FROM public.book_category WHERE name = 'Horror'), 'Ghost Stories', 7.99, 0, 0, 192, 357, DATE '2016-10-06', 'There''s nothing sinister about a London bus. Nothing supernatural could occur on a busy Tube platform. There''s nothing terrifying about a little caterpillar. And a telephone, what could be scary about that? Don''t be frightened of the dark corners of your room.', 'https://cdn.penguin.co.uk/dam-assets/books/9781784871901/9781784871901-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'colson whitehead'), (SELECT id FROM public.book_category WHERE name = 'Horror'), 'Zone One', 12.5, 0, 0, 272, 549, DATE '2017-11-16', 'A pandemic has devastated the planet, sorting humanity into two types: the uninfected and the infected, the living and the living dead. The worst of the plague is now past, and Manhattan is slowly being resettled. Armed forces havesuccessfully reclaimed the island south of Canal Street - aka ''Zone One'' and teams of civilian volunteers are clearing out the remaining infected ''stragglers''.', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Shirley Jackson'), (SELECT id FROM public.book_category WHERE name = 'Horror'), 'The Haunting of Hill House', 14.99, 0, 0, 208, 435, DATE '2013-10-03', 'First published in 1959, Shirley Jackson''s The Haunting of Hill House has been hailed as a perfect work of unnerving terror. It is the story of four seekers who arrive at a notoriously unfriendly pile called Hill House: Dr. Montague, an occult scholar looking for solid evidence of a ''haunting''; Theodora, his lighthearted assistant; Eleanor, a friendless, fragile young woman well acquainted with poltergeists; and Luke, the future heir of Hill House.', 'https://cdn.penguin.co.uk/dam-assets/books/9780143122357/9780143122357-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Bram Stoker'), (SELECT id FROM public.book_category WHERE name = 'Classic'), 'Dracula', 6.99, 0, 0, 656, 1446, DATE '2013-10-03', 'I am Dracula. And I bid you welcome to my house. He is deathly pale. His fingernails are cut to sharp points. His teeth protrude menacingly from his mouth in clouds of rancid breath... Yet even Count.', 'https://cdn.penguin.co.uk/dam-assets/books/9780099582595/9780099582595-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Gabriel Garcia Marquez'), (SELECT id FROM public.book_category WHERE name = 'Classic'), 'One Hundred Years of Solitude', 9.99, 0, 0, 432, 904, DATE '2020-03-05', 'ONE OF THE WORLD''S MOST FAMOUS BOOKS AND WINNER OF THE NOBEL PRIZE FOR LITERATURE', 'https://cdn.penguin.co.uk/dam-assets/books/9780241968581/9780241968581-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Leo Tolstoy'), (SELECT id FROM public.book_category WHERE name = 'Classic'), 'War And Peace', 20, 0, 0, 1440, 3056, DATE '2016-01-07', 'A beautiful Penguin clothbound edition of Tolstoy''s magnificent epic novel of love, conflict, fate and human life in all its imperfection and grandeur', 'https://cdn.penguin.co.uk/dam-assets/books/9780241265543/9780241265543-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Harper Lee'), (SELECT id FROM public.book_category WHERE name = 'Classic'), 'To Kill A Mockingbird', 7.99, 0, 0, 320, 664, DATE '2020-07-09', 'Shoot all the bluejays you want, if you can hit ''em, but remember it''s a sin to kill a mockingbird.', 'https://cdn.penguin.co.uk/dam-assets/books/9780099549482/9780099549482-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Anthony Burgess'), (SELECT id FROM public.book_category WHERE name = 'Classic'), 'A Clockwork Orange', 8.99, 0, 0, 325, 674, DATE '2013-12-05', 'Fully restored edition of Anthony Burgess'' original text of A Clockwork Orange, with a glossary of the teen slang ''Nadsat'', explanatory notes, pages from the original typescript, interviews, articles and reviews.', 'https://cdn.penguin.co.uk/dam-assets/books/9780141197531/9780141197531-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Sadeq Hedayat'), (SELECT id FROM public.book_category WHERE name = 'Classic'), 'Blind Owl', 10.99, 0, 0, 112, 246, DATE '2022-10-06', 'Blind Owl, Sadeq Hedayat''s masterpiece, tells the story of a young pen-casepainter and his heartbreak. Isolated and alone, he mourns the loss of a mysterious love while descending into recollections and dreams frosted over by opium and alcohol, and imbued with the images he paints: an old man, a cypress tree, a beautiful woman, a water lily', 'https://cdn.penguin.co.uk/dam-assets/books/9780143136583/9780143136583-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Georgette Heyer'), (SELECT id FROM public.book_category WHERE name = 'Classic'), 'My Lord John', 9.99, 0, 0, 400, 845, DATE '2022-11-10', 'Through his loyalty, strength, and superb fighting power, he would go on to became the greatest ally his brother, King Henry V, could have asked for.', 'https://cdn.penguin.co.uk/dam-assets/books/9780099476429/9780099476429-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Oscar Wilde'), (SELECT id FROM public.book_category WHERE name = 'Classic'), 'The Picture of Dorian Gray', 16.99, 0, 0, 304, 678, DATE '2009-09-03', 'Part of Penguin''s beautiful hardback Clothbound Classic series, designed by the award-winning Coralie Bickford-Smith, these delectable and collectible editions are bound in high-quality colourful, tactile cloth with foil stamped into the design.', 'https://cdn.penguin.co.uk/dam-assets/books/9780141442464/9780141442464-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Harold Sonny Ladoo'), (SELECT id FROM public.book_category WHERE name = 'Classic'), 'No Pain Like This Body', 8.99, 0, 0, 224, 482, DATE '2022-08-04', 'In the Caribbean, at the beginning of the last century, a poor rice-growing family struggle to exist. Four siblings pass their days in the ricefield, as does Ma. But Pa is an angry man ready to vent. It is the August rainy season and above their heads the black sky crackles with lightning.', 'https://cdn.penguin.co.uk/dam-assets/books/9781784877026/9781784877026-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Kahlil Gibran'), (SELECT id FROM public.book_category WHERE name = 'Classic'), 'The Prophet', 9.99, 0, 0, 128, 265, DATE '2022-08-25', 'Introducing Little Clothbound Classicirresistible, mini editions of short stories, novellas and essays from the world''s greatest writers, designed by the awardwinning Coralie Bickford-Smith.', 'https://cdn.penguin.co.uk/dam-assets/books/9780241573716/9780241573716-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Clive Cussler'), (SELECT id FROM public.book_category WHERE name = 'Action and Adventure'), 'Odessa Sea', 8.99, 0, 0, 480, 972, DATE '2017-12-14', 'As Director of the National Underwater and Marine Agency, Dirk Pitt has always had a knack for finding rouble. This time, though, trouble has found him . . .', 'https://cdn.penguin.co.uk/dam-assets/books/9781405927659/9781405927659-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Robert Harris'), (SELECT id FROM public.book_category WHERE name = 'Action and Adventure'), 'Fatherland', 8.99, 0, 0, 560, 1235, DATE '2017-08-10', 'The highest form of thriller . . . non-stop excitement'' The Times', 'https://cdn.penguin.co.uk/dam-assets/books/9781787460485/9781787460485-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'George Psychoundakis'), (SELECT id FROM public.book_category WHERE name = 'Action and Adventure'), 'The Cretan Runner', 10.99, 0, 0, 368, 782, DATE '2009-08-06', 'The legendary story of a resistance hero', 'https://cdn.penguin.co.uk/dam-assets/books/9780141043340/9780141043340-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'John Buchan'), (SELECT id FROM public.book_category WHERE name = 'Action and Adventure'), 'The Thirty-Nine Steps', 6.99, 0, 0, 272, 538, DATE '2011-01-06', 'Discover the original and best adventure story ever told.', 'https://cdn.penguin.co.uk/dam-assets/books/9780099528395/9780099528395-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Michael Crichton'), (SELECT id FROM public.book_category WHERE name = 'Action and Adventure'), 'Jurassic Park', 8.99, 0, 0, 480, 938, DATE '2015-05-21', 'Breathtaking adventure. . . a book that is as hard to put down as it is to forget', 'https://cdn.penguin.co.uk/dam-assets/books/9781784752224/9781784752224-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Robert Harris'), (SELECT id FROM public.book_category WHERE name = 'Action and Adventure'), 'Munich', 8.99, 0, 0, 448, 977, DATE '2022-01-06', 'MUNICH, SEPTEMBER 1938 Hitler is determined to start a war. Chamberlain is desperate to preserve the peace. They will meet in a city which forever afterwards will be known for what is aboutto take place.', 'https://cdn.penguin.co.uk/dam-assets/books/9781787467996/9781787467996-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Andy Weir'), (SELECT id FROM public.book_category WHERE name = 'Action and Adventure'), 'The Martian', 8.99, 0, 0, 384, 745, DATE '2015-08-27', 'A survival story for the 21st century and the international bestseller behind the major film from Ridley Scott, starring Matt Damon and Jessica Chastain.', 'https://cdn.penguin.co.uk/dam-assets/books/9781785031137/9781785031137-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Dan Brown'), (SELECT id FROM public.book_category WHERE name = 'Action and Adventure'), 'Origin', 9.99, 0, 0, 560, 1074, DATE '2018-07-12', 'The global bestseller - Origin is the latest Robert Langdon novel from the authorName of The Da Vinci Code.', 'https://cdn.penguin.co.uk/dam-assets/books/9780552174169/9780552174169-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Dan Brown'), (SELECT id FROM public.book_category WHERE name = 'Action and Adventure'), 'Great Circle', 8.99, 0, 0, 688, 1378, DATE '2022-05-26', 'A soaring, breathtakingly ambitious novel that weaves together the astonishing lives of a 1950s vanished female aviator and the modern-day Hollywood actress who plays her on screen.', 'https://cdn.penguin.co.uk/dam-assets/books/9781529176643/9781529176643-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Marc Cameron'), (SELECT id FROM public.book_category WHERE name = 'Action and Adventure'), 'Tom Clancy''s Oath of Office', 7.99, 0, 0, 544, 1146, DATE '2019-10-17', 'As the Kremlin orders troops to mass on the Ukrainian border, a Russian planecarrying nukes disappears mid-flight.', 'https://cdn.penguin.co.uk/dam-assets/books/9781405935470/9781405935470-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Emma Morgan'), (SELECT id FROM public.book_category WHERE name = 'Romantic'), 'A Love Story for Bewildered Girls', 8.99, 0, 0, 172, 349, DATE '2020-08-13', 'An utterly gorgeous novel. It will forever hold my heart in its pages'' Pandora Sykes, co-host of The High-Low podcast', 'https://cdn.penguin.co.uk/dam-assets/books/9780241984680/9780241984680-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Howard Jacobson'), (SELECT id FROM public.book_category WHERE name = 'Romantic'), 'Live a Little', 8.99, 0, 0, 288, 544, DATE '2020-08-06', 'A . . . tender love story . . . This book is alive. It pulses with warmth and intelligence'' The Times. A wickedly observed novel about falling in love at the end of your life', 'https://cdn.penguin.co.uk/dam-assets/books/9781529110555/9781529110555-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Jane Sanderson'), (SELECT id FROM public.book_category WHERE name = 'Romantic'), 'Mix Tape', 7.99, 0, 0, 416, 838, DATE '2020-09-17', 'This tender tale of second chances... is a nostalgic delight', 'https://cdn.penguin.co.uk/dam-assets/books/9781784164850/9781784164850-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Jojo Moyes'), (SELECT id FROM public.book_category WHERE name = 'Romantic'), 'The Giver of Stars', 9.99, 0, 0, 464, 923, DATE '2022-06-09', 'A spellbinding story of love, community and the power of reading from the authorName of The Last Letter from Your Lover, now a major motion picture, and Me before You', 'https://cdn.penguin.co.uk/dam-assets/books/9780718183219/9780718183219-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Georgette Heyer'), (SELECT id FROM public.book_category WHERE name = 'Romantic'), 'Snowdrift and Other Stories', 8.99, 0, 0, 384, 795, DATE '2017-10-19', 'Previously titled Pistols for two, this collection includes three of Heyer''s earliest short stories, published together in book form for the very first time. A treat for all fans of Georgette Heyer, and for those who love stories full of romance and intrigue.', 'https://cdn.penguin.co.uk/dam-assets/books/9781784756130/9781784756130-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Georgette Heyer'), (SELECT id FROM public.book_category WHERE name = 'Romantic'), 'Regency Buck', 8.99, 0, 0, 368, 723, DATE '2020-03-12', 'Beautiful heiress Judith Taverner has her pick of London suitors. But her luck takes a turn for the worse when her hapless brother, Peregrine, becomes the target of a would-be-assassin.', 'https://cdn.penguin.co.uk/dam-assets/books/9780099465584/9780099465584-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Isabelle Broom'), (SELECT id FROM public.book_category WHERE name = 'Romantic'), 'One Winter Morning', 0.99, 0, 0, 400, 822, DATE '2019-08-29', 'The frosty mornings and twinkling fairy lights only remind her it''s been a whole year since she lost her adoptive mother, who took her in as a baby and raised her as her own', 'https://cdn.penguin.co.uk/dam-assets/books/9781405935517/9781405935517-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Anne Youngson'), (SELECT id FROM public.book_category WHERE name = 'Romantic'), 'Meet Me at the Museum', 8.99, 0, 0, 240, 467, DATE '2019-12-26', 'Meet Me at the Museum tells of a connection made across oceans and against all the odds. Through intimate stories of joy, despair, and discovery, two people are drawn inexorably towards the other, until a shattering revelation pushes their friendship to the very edge. ', 'https://cdn.penguin.co.uk/dam-assets/books/9781784163464/9781784163464-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Marian Keyes'), (SELECT id FROM public.book_category WHERE name = 'Romantic'), 'Rachel''s Holiday', 8.99, 0, 0, 640, 1342, DATE '2021-12-09', 'She''s been living it up in New York City, spending her nights talking her way into glamorous parties before heading home in the early hours to her adoring boyfriend,Luke.', 'https://cdn.penguin.co.uk/dam-assets/books/9780241958438/9780241958438-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Lisa Jewell'), (SELECT id FROM public.book_category WHERE name = 'Romantic'), 'After the Party', 8.99, 0, 0, 512, 1099, DATE '2016-04-07', 'Eleven years ago, Jem and Ralph fell in love. They thought it would be for ever, that they''d found their happy ending.', 'https://cdn.penguin.co.uk/dam-assets/books/9780099533689/9780099533689-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Roald Dahl'), (SELECT id FROM public.book_category WHERE name = 'Kids'), 'The Twits', 6.99, 0, 0, 144, 274, DATE '2022-07-21', 'To pay Mrs. Twit back for the worms in his spaghetti, Mr. Twit thought up a really clever, nasty trick . . .', 'https://cdn.penguin.co.uk/dam-assets/books/9780241578186/9780241578186-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Lee Newbery'), (SELECT id FROM public.book_category WHERE name = 'Kids'), 'The Last Firefox', 7.99, 0, 0, 304, 674, DATE '2022-03-03', 'Between bullies at school and changes at home, Charlie Challinor finds life a bit scary. And when he''s made guardian of a furry fox cub called Cadno, things get a whole lot scarier.', 'https://cdn.penguin.co.uk/dam-assets/books/9780241493533/9780241493533-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Chris Smith'), (SELECT id FROM public.book_category WHERE name = 'Kids'), 'Frankie Best Hates Quests', 8.99, 0, 0, 400, 955, DATE '2022-03-31', 'From the incredible imagination of Chris Smith - bestselling authorName and now a major new solo talent - comes an extraordinary accidental adventure for fans of Cressida Cowell and Pixar''s Onward.', 'https://cdn.penguin.co.uk/dam-assets/books/9780241522110/9780241522110-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Adam Kay'), (SELECT id FROM public.book_category WHERE name = 'Kids'), 'Kay''s Marvellous Medicine', 8.99, 0, 0, 416, 845, DATE '2022-07-21', 'The brand-new, hilarious book from bestselling, record-breaking authorName Adam Kay', 'https://cdn.penguin.co.uk/dam-assets/books/9780241508541/9780241508541-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Leisa Stewart-Sharpe'), (SELECT id FROM public.book_category WHERE name = 'Kids'), 'The Green Planet', 16.99, 0, 0, 64, 130, DATE '2022-01-06', 'In the world of plants, time passes more slowly, but if we speed months into minutes we can peer into this hidden world and realise: it''s a battleground. Plants are working to thwart their enemies, and to trick animals into working for them.', 'https://cdn.penguin.co.uk/dam-assets/books/9781405946667/9781405946667-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Jacqueline Wilson'), (SELECT id FROM public.book_category WHERE name = 'Kids'), 'The Primrose Railway Children', 7.99, 0, 0, 512, 1078, DATE '2022-06-09', 'Phoebe Robinson loves making up stories - just like her wonderful, imaginative Dad.', 'https://cdn.penguin.co.uk/dam-assets/books/9780241537633/9780241537633-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Dick King-Smith'), (SELECT id FROM public.book_category WHERE name = 'Kids'), 'Ambrose Follows His Nose', 10.99, 0, 0, 176, 374, DATE '2022-03-03', 'An exciting new publication in celebration of the centenary of his birth, a recently discovered funny and poignant animal story by Dick King-Smith, completed by his great granddaughter, Josie Rogers.', 'https://cdn.penguin.co.uk/dam-assets/books/9780241488409/9780241488409-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Beatrix Potter'), (SELECT id FROM public.book_category WHERE name = 'Kids'), 'The Tale Of Peter Rabbit', 9.99, 0, 0, 80, 178, DATE '2022-02-03', 'This birthday edition has been re-originated to match Beatrix Potter''s first published work with a celebratory new cover.', 'https://cdn.penguin.co.uk/dam-assets/books/9780241513729/9780241513729-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Kim Hillyard'), (SELECT id FROM public.book_category WHERE name = 'Kids'), 'Gretel the Wonder Mammoth', 6.99, 0, 0, 32, 74, DATE '2022-03-03', 'One peaceful Tuesday morning, a loud CRACK could be heard as the last mammoth on earth broke free from her icy shell - here comes Gretel the Wonder Mammoth! Everyone is so excited to meet her but as she settles into her new life, Gretel starts to feel a little overwhelmed and even a bit lonely... ', 'https://cdn.penguin.co.uk/dam-assets/books/9780241488560/9780241488560-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Sharna Jackson'), (SELECT id FROM public.book_category WHERE name = 'Kids'), 'The Good Turn', 7.99, 0, 0, 400, 844, DATE '2022-05-12', 'For 9+ readers, this gripping, thoughtful update to the Blytonesque ''secret society'' genre engages squarely with racism and social injustice.', 'https://cdn.penguin.co.uk/dam-assets/books/9780241523599/9780241523599-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Ta-Nehisi Coates'), (SELECT id FROM public.book_category WHERE name = 'History'), 'We Were Eight Years in Power', 9.99, 0, 0, 384, 744, DATE '2018-11-01', 'Obama''s presidency was a watershed moment in American history. From 2008-2016, the leader of the free world was a black man. In those eight years, Obama transformed the conversation around race, gender, class and wealth - inspiring hope but also attracting criticism and breeding discontent.', 'https://cdn.penguin.co.uk/dam-assets/books/9780241982495/9780241982495-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Christopher Harding'), (SELECT id FROM public.book_category WHERE name = 'History'), 'Japan Story', 7.99, 0, 0, 400, 865, DATE '2018-11-01', 'It is told through the eyes of people who greeted this change not with the confidence and grasping ambition of Japan''s modernizers and nationalists, but with resistance, conflict, distress. ', 'https://cdn.penguin.co.uk/dam-assets/books/9780141985367/9780141985367-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Leisa Stewart-Sharpe'), (SELECT id FROM public.book_category WHERE name = 'History'), 'Hitler', 9.99, 0, 0, 1072, 2279, DATE '2013-03-07', 'Ian Kershaw''s two volume biography, Hitler 1889-1936: Hubris and Hitler 1936-1945: Nemesis, was greeted with universal acclaim as the essential work on one of the most malign figures in history, from his earliest origins to the final days of the Second World War. ', 'https://cdn.penguin.co.uk/dam-assets/books/9780141909592/9780141909592-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Piers Brendon'), (SELECT id FROM public.book_category WHERE name = 'History'), 'Churchill', 8.99, 0, 0, 256, 574, DATE '2011-08-31', 'This astute biography brilliantly captures, in one volume, the full range of Winston Churchill''s astonishing career. perhaps the greatest political figure of modern times, Churchill''s achievement extended well beyond his emblematic role in the Second World War. ', 'https://cdn.penguin.co.uk/dam-assets/books/9781446484920/9781446484920-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Ian Blatchford'), (SELECT id FROM public.book_category WHERE name = 'History'), 'The Art of Innovation', 10.99, 0, 0, 320, 741, DATE '2019-09-19', 'Based on the landmark Radio 4 series, this beautifully illustrated modern history ofthe connections between science and art offers a new perspective on what thatrelationship has contributed to the world around us.', 'https://cdn.penguin.co.uk/dam-assets/books/9781473570733/9781473570733-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'David Abulafia'), (SELECT id FROM public.book_category WHERE name = 'History'), 'The Boundless Sea', 7.99, 0, 0, 1088, 2374, DATE '2019-10-03', 'For most of human history, the seas and oceans have been the main means of longdistance trade and communication between peoples - for the spread of ideas and religion as well as commerce.', 'https://cdn.penguin.co.uk/dam-assets/books/9780141972091/9780141972091-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Horatio Clare'), (SELECT id FROM public.book_category WHERE name = 'History'), 'Icebreaker', 8.99, 0, 0, 224, 474, DATE '2019-04-04', 'We are celebrating a hundred years since independence this year: how would you like to travel on a government icebreaker?', 'https://cdn.penguin.co.uk/dam-assets/books/9781784706791/9781784706791-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Sathnam Sanghera'), (SELECT id FROM public.book_category WHERE name = 'History'), 'Empireland', 9.99, 0, 0, 254, 536, DATE '2021-10-07', 'Strangely hidden from view, the British Empire remains a subject of both shame and glorification. In his bestselling book, Sathnam Sanghera shows how our imperial past is everywhere: from how we live and think to the foundation of the NHS and even our response to the COVID-19 crisis.', 'https://cdn.penguin.co.uk/dam-assets/books/9780241445310/9780241445310-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Adam Higginbotham'), (SELECT id FROM public.book_category WHERE name = 'History'), 'Midnight in Chernobyl', 7.99, 0, 0, 560, 1178, DATE '2019-02-14', 'Chernobyl has become lodged in the collective nightmares of the world: shorthand for the spectral horrors of radiation poisoning, for a dangerous technology slipping its leash, for ecological fragility, and for what can happen when a dishonest and careless state endangers not only its own citizens, but all of humanity.', 'https://cdn.penguin.co.uk/dam-assets/books/9781473540828/9781473540828-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'David Montenegro'), (SELECT id FROM public.book_category WHERE name = 'History'), 'The Red Arrows', 20, 0, 0, 288, 512, DATE '2022-05-26', 'The Red Arrows represent the very best speed, agility and precision aerobatic flying in the Royal Air Force, and the people who wear those iconic red flight suits are rigorously selected not just for their flying skills, lightning-fast reflexes and nerves of steel, but for their mental resilience, courage and humility', 'https://cdn.penguin.co.uk/dam-assets/books/9781529135527/9781529135527-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'P. G. Wodehouse'), (SELECT id FROM public.book_category WHERE name = 'Sport'), 'Above Average at Games', 25, 0, 0, 416, 866, DATE '2019-10-31', 'As Wodehouse''s biographer Frances Donaldson observed, it was vitally important to the boy Plum that he was ''above average at games''. Luckily, he was known at school as ''a noted athlete, a fine footballer and cricketer [and] a boxer'', and sport inspired much of his earliest writings, as well as some of his very finest and laughout-loud funniest.', 'https://cdn.penguin.co.uk/dam-assets/books/9781786332004/9781786332004-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Zlatan Ibrahimovic'), (SELECT id FROM public.book_category WHERE name = 'Sport'), 'Adrenaline', 10.99, 0, 0, 272, 577, DATE '2022-07-28', 'Football''s most prolific and controversial goal scorer has nothing left to prove on the pitch. There is only one Zlatan.', 'https://cdn.penguin.co.uk/dam-assets/books/9780241996089/9780241996089-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Richard Askwith'), (SELECT id FROM public.book_category WHERE name = 'Sport'), 'The Race Against Time', 9.99, 0, 0, 288, 598, DATE '2023-01-12', 'What do you do when the sport that has been your lifeline to physical and mental well-being starts to slip away from you?', 'https://cdn.penguin.co.uk/dam-assets/books/9781473574083/9781473574083-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Nicola Adams'), (SELECT id FROM public.book_category WHERE name = 'Sport'), 'Believe', 4.99, 0, 0, 256, 545, DATE '2017-05-18', 'At London 2012, Nicola Adams made history when she became the first woman ever to win an Olympic Gold medal for boxing. In Rio 2016, with the nation cheering her on, she did it all over again.', 'https://cdn.penguin.co.uk/dam-assets/books/9780241980545/9780241980545-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Ed Warner'), (SELECT id FROM public.book_category WHERE name = 'Sport'), 'Sport Inc.', 10.99, 0, 0, 304, 624, DATE '2019-09-19', 'Sport Inc. reveals the behind-the-scenes finances that drive sport - who gets rich and who gets left on the bench.', 'https://cdn.penguin.co.uk/dam-assets/books/9781787290136/9781787290136-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'John D. Barrow'), (SELECT id FROM public.book_category WHERE name = 'Sport'), '100 Essential Things You Didn''t Know You Didn''t Know About Sport', 3.99, 0, 0, 320, 748, DATE '2012-03-15', '100 Essential Things You Didn''t Know You Didn''t Know about Sport sheds light on the mysteries of running, jumping, swimming and points scoring across the whole sporting spectrum.', 'https://cdn.penguin.co.uk/dam-assets/books/9781448129546/9781448129546-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Bear Grylls'), (SELECT id FROM public.book_category WHERE name = 'Sport'), 'Never Give Up', 9.99, 0, 0, 416, 912, DATE '2021-10-28', 'Bear Grylls has always sought out adventure. From childhood escapades to wouldrecord-breaking expeditions, to his infamous survival challenges, Bear has spent a lifetime in the wild.', 'https://cdn.penguin.co.uk/dam-assets/books/9781473584938/9781473584938-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

INSERT INTO public.book
(author_id, category_id, name, price, rate, users_rate_count, pages_number, reading_duration, publish_date, description, image_url, created_date, modified_date, created_by, modified_by, marked_as_deleted)
VALUES ((SELECT id FROM public.author WHERE name = 'Billie Jean King'), (SELECT id FROM public.book_category WHERE name = 'Sport'), 'All In', 5.99, 0, 0, 496, 966, DATE '2021-09-09', 'An inspiring and intimate self-portrait of the champion of equality that encompasses her brilliant tennis career, unwavering activism, and an ongoing commitment to fairness and social justice.', 'https://cdn.penguin.co.uk/dam-assets/books/9780241430613/9780241430613-jacket-large.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'json-seed', 'json-seed', FALSE);

COMMIT;
