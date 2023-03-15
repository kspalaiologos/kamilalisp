package palaiologos.kamilalisp.runtime.lib;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.runtime.array.hof.ParallelFilter;
import palaiologos.kamilalisp.runtime.array.hof.ParallelMapIdx;
import palaiologos.kamilalisp.runtime.array.sais.SacaBwt;
import palaiologos.kamilalisp.runtime.array.sais.SacaSais;
import palaiologos.kamilalisp.runtime.array.sais.SacaUnbwt;
import palaiologos.kamilalisp.runtime.cas.MatrixDet;
import palaiologos.kamilalisp.runtime.cas.MatrixLUDecomposition;
import palaiologos.kamilalisp.runtime.cas.MatrixTrace;
import palaiologos.kamilalisp.runtime.dataformat.*;
import palaiologos.kamilalisp.runtime.dataformat.digest.*;
import palaiologos.kamilalisp.runtime.datetime.*;
import palaiologos.kamilalisp.runtime.graph.*;
import palaiologos.kamilalisp.runtime.hashmap.*;
import palaiologos.kamilalisp.runtime.math.num.*;
import palaiologos.kamilalisp.runtime.meta.*;
import palaiologos.kamilalisp.runtime.parallel.Daemon;
import palaiologos.kamilalisp.runtime.parallel.Task;
import palaiologos.kamilalisp.runtime.parallel.actor.ActorCreate;
import palaiologos.kamilalisp.runtime.regex.RegexMatches;
import palaiologos.kamilalisp.runtime.regex.RegexReplace;
import palaiologos.kamilalisp.runtime.regex.RegexSplit;

public class AlgorithmLib {
    public static void register(Environment env) {
        env.setPrimitive("meta:env-keys", "⊚⍠", new Atom(new EnvKeys()));
        env.setPrimitive("meta:to-glyphs", "⊚∊", new Atom(new ToGlyphs()));
        env.setPrimitive("meta:to-ascii", "⊚∉", new Atom(new ToASCII()));
        env.setPrimitive("meta:type-name", "⊚?", new Atom(new TypeName()));
        env.setPrimitive("meta:atom", "→⊚", new Atom(new MetaAtom()));

        env.setPrimitive("digest:md2", new Atom(new Md2Digest()));
        env.setPrimitive("digest:md5", new Atom(new Md5Digest()));
        env.setPrimitive("digest:sha1", new Atom(new Sha1Digest()));
        env.setPrimitive("digest:sha256", new Atom(new Sha256Digest()));
        env.setPrimitive("digest:sha384", new Atom(new Sha384Digest()));
        env.setPrimitive("digest:sha512", new Atom(new Sha512Digest()));
        env.setPrimitive("digest:xxh32", new Atom(new XXHash32Digest()));
        env.setPrimitive("digest:crc32", new Atom(new CRC32Digest()));
        env.setPrimitive("digest:crc32c", new Atom(new CRC32CDigest()));
        env.setPrimitive("digest:adler32", new Atom(new Adler32Digest()));
        env.setPrimitive("digest:sha3224", new Atom(new Sha3224Digest()));
        env.setPrimitive("digest:sha3256", new Atom(new Sha3256Digest()));
        env.setPrimitive("digest:sha3384", new Atom(new Sha3384Digest()));
        env.setPrimitive("digest:sha3512", new Atom(new Sha3512Digest()));
        env.setPrimitive("digest:sha512224", new Atom(new Sha512224Digest()));
        env.setPrimitive("digest:sha512256", new Atom(new Sha512256Digest()));

        env.setPrimitive("saca:sais", new Atom(new SacaSais()));
        env.setPrimitive("saca:bwt", new Atom(new SacaBwt()));
        env.setPrimitive("saca:unbwt", new Atom(new SacaUnbwt()));

        env.setPrimitive("num:LU", "⎕↙↗", new Atom(new LUDecomposition()));
        env.setPrimitive("num:PLU", "⎕⍉↙↗", new Atom(new PLUDecomposition()));
        env.setPrimitive("num:QR", new Atom(new QRDecomposition()));
        env.setPrimitive("num:trace", "⎕∑", new Atom(new Trace()));
        env.setPrimitive("num:det", "⎕∆", new Atom(new Det()));
        env.setPrimitive("num:permanent", "⎕∆⍴", new Atom(new Permanent()));
        env.setPrimitive("num:I", "⎕I", new Atom(new I()));
        env.setPrimitive("num:invert", "⎕¯¹", new Atom(new Inv()));

        env.setPrimitive("cas:matrix:trace", "⎕ƒ∑", new Atom(new MatrixTrace()));
        env.setPrimitive("cas:matrix:LU", "⎕ƒ↙↗", new Atom(new MatrixLUDecomposition()));
        env.setPrimitive("cas:matrix:det", "⎕ƒ∆", new Atom(new MatrixDet()));

        env.setPrimitive("xml:parse", new Atom(new XmlParse()));
        env.setPrimitive("xml:write", new Atom(new XmlWrite()));
        env.setPrimitive("xml:escape", new Atom(new XmlEscape()));
        env.setPrimitive("xml:unescape", new Atom(new XmlUnescape()));
        env.setPrimitive("csv:parse", new Atom(new CsvParse()));
        env.setPrimitive("csv:write", new Atom(new CsvWrite()));
        env.setPrimitive("json:parse", new Atom(new JsonParse()));
        env.setPrimitive("json:write", new Atom(new JsonWrite()));

        env.setPrimitive("codec:gzip-compress", new Atom(new GzipCompress()));
        env.setPrimitive("codec:gzip-decompress", new Atom(new GzipDecompress()));
        env.setPrimitive("codec:bzip2-compress", new Atom(new Bzip2Compress()));
        env.setPrimitive("codec:bzip2-decompress", new Atom(new Bzip2Decompress()));
        env.setPrimitive("codec:lz4-compress", new Atom(new Lz4Compress()));
        env.setPrimitive("codec:lz4-decompress", new Atom(new Lz4Decompress()));
        env.setPrimitive("codec:xz-compress", new Atom(new XzCompress()));
        env.setPrimitive("codec:xz-decompress", new Atom(new XzDecompress()));
        env.setPrimitive("codec:base64-encode", new Atom(new Base64Encode()));
        env.setPrimitive("codec:base64-decode", new Atom(new Base64Decode()));

        env.setPrimitive("hashmap:from-list", "⍔⌿", new Atom(new HashMapFromList()));
        env.setPrimitive("hashmap:as-list", "⍔⍀", new Atom(new HashMapAsList()));
        env.setPrimitive("hashmap:size", "⍔⍴", new Atom(new HashMapSize()));
        env.setPrimitive("hashmap:key-list", "⍔⍎", new Atom(new HashMapKeyList()));
        env.setPrimitive("hashmap:value-list", "⍔⍕", new Atom(new HashMapValueList()));
        env.setPrimitive("hashmap:contains-key?", "⍔⍎?", new Atom(new HashMapContainsKey()));
        env.setPrimitive("hashmap:contains-value?", "⍔⍕?", new Atom(new HashMapContainsValue()));
        env.setPrimitive("hashmap:get", "⍔⍆", new Atom(new HashMapGet()));
        env.setPrimitive("hashmap:get-or", "⍔⍆?", new Atom(new HashMapGetOrDefault()));
        env.setPrimitive("hashmap:adjoin", "⍔+", new Atom(new HashMapAdjoin()));
        env.setPrimitive("hashmap:minus", "⍔-", new Atom(new HashMapMinus()));
        env.setPrimitive("hashmap:merge", "⍔⋃", new Atom(new HashMapMerge()));
        env.setPrimitive("hashmap:without", "⍔⍪", new Atom(new HashMapWithout()));
        env.setPrimitive("hashmap:group", "⍔⌸", new Atom(new HashMapGroup()));
        env.setPrimitive("hashmap:process", "⍔∵", new Atom(new HashMapProcess()));

        env.setPrimitive("graph:simple", new Atom(new Simple()));
        env.setPrimitive("graph:simple-weighted", new Atom(new SimpleWeighted()));
        env.setPrimitive("graph:simple-directed", new Atom(new SimpleDirected()));
        env.setPrimitive("graph:bfs", new Atom(new BFS()));
        env.setPrimitive("graph:dfs", new Atom(new DFS()));
        env.setPrimitive("graph:cfs", new Atom(new CFS()));
        env.setPrimitive("graph:mcs", new Atom(new MCS()));
        env.setPrimitive("graph:tos", new Atom(new TOS()));
        env.setPrimitive("graph:rs", new Atom(new RS()));
        env.setPrimitive("graph:stoer-wagner", new Atom(new StoerWagner()));
        env.setPrimitive("graph:transitive-reduction", new Atom(new TransitiveReduction()));
        env.setPrimitive("graph:transitive-closure", new Atom(new TransitiveClosure()));
        env.setPrimitive("graph:girvan-newman-clustering", new Atom(new GirvanNewmanClustering()));
        env.setPrimitive("graph:k-spanning-clustering", new Atom(new KSpanningClustering()));
        env.setPrimitive("graph:label-propagation-clustering", new Atom(new LabelPropagationClustering()));
        env.setPrimitive("graph:brown-backtrack-colouring", new Atom(new BrownBacktrackColouring()));
        env.setPrimitive("graph:chordal-colouring", new Atom(new ChordalGraphColouring()));
        env.setPrimitive("graph:refinement-colouring", new Atom(new RefinementColouring()));
        env.setPrimitive("graph:greedy-colouring", new Atom(new GreedyColouring()));
        env.setPrimitive("graph:random-greedy-colouring", new Atom(new RandomGreedyColouring()));
        env.setPrimitive("graph:largest-degree-first-colouring", new Atom(new LargestDegreeFirstColouring()));
        env.setPrimitive("graph:saturation-degree-colouring", new Atom(new SaturationDegreeColouring()));
        env.setPrimitive("graph:smallest-degree-last-colouring", new Atom(new SmallestDegreeLastColouring()));
        env.setPrimitive("graph:bipartite", new Atom(new Bipartite()));
        env.setPrimitive("graph:dense-edmonds-mc-matching", new Atom(new DenseEdmondsMatching()));
        env.setPrimitive("graph:sparse-edmonds-mc-matching", new Atom(new SparseEdmondsMatching()));
        env.setPrimitive("graph:greedy-mc-matching", new Atom(new GreedyMCMatching()));
        env.setPrimitive("graph:greedy-w-matching", new Atom(new GreedyWMatching()));
        env.setPrimitive("graph:hopcroft-karp-mc-bipartite-matching", new Atom(new HopcroftKarpMCBipartiteMatching()));
        env.setPrimitive("graph:kuhn-munkres-mw-bipartite-perfect-matching", new Atom(new KuhnMunkresMWBipartitePerfectMatching()));
        env.setPrimitive("graph:maximum-weight-bipartite-matching", new Atom(new MWBipartiteMatching()));
        env.setPrimitive("graph:zhang-shasha-tree-edit-distance", new Atom(new ZhangShashaTreeEditDistance()));

        env.setPrimitive("regex:matches?", "⍫⊖∊?", new Atom(new RegexMatches()));
        env.setPrimitive("regex:replace", "⍫⊖⍆", new Atom(new RegexReplace()));
        env.setPrimitive("regex:split", "⍫⊖⍭", new Atom(new RegexSplit()));

        env.setPrimitive("date:from", new Atom(new DateTimeFrom()));
        env.setPrimitive("time:from", new Atom(new TimeFrom()));
        env.setPrimitive("time:hours", new Atom(new TimeHours()));
        env.setPrimitive("time:minutes", new Atom(new TimeMinutes()));
        env.setPrimitive("time:seconds", new Atom(new TimeSeconds()));
        env.setPrimitive("time:nanoseconds", new Atom(new TimeNanoseconds()));
        env.setPrimitive("date:years", new Atom(new DateYears()));
        env.setPrimitive("date:months", new Atom(new DateMonths()));
        env.setPrimitive("date:days", new Atom(new DateDays()));
        env.setPrimitive("date:now-utc", new Atom(new DateNow()));
        env.setPrimitive("date:now", new Atom(new DateNowTZ()));
        env.setPrimitive("time:now-utc", new Atom(new TimeNow()));
        env.setPrimitive("time:now", new Atom(new TimeNowTZ()));
        env.setPrimitive("date:parse", new Atom(new DateParse()));
        env.setPrimitive("time:parse", new Atom(new TimeParse()));

        env.setPrimitive("parallel:task", "∥⎕", new Atom(new Task()));
        env.setPrimitive("parallel:daemon", "∥⍌", new Atom(new Daemon()));
        env.setPrimitive("parallel:actor", "∥⍓", new Atom(new ActorCreate()));
        env.setPrimitive("parallel:map-idx", "⍠∵", new Atom(new ParallelMapIdx()));
        env.setPrimitive("parallel:filter", "⍭∵", new Atom(new ParallelFilter()));
    }
}
