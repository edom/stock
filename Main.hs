module Main
(
    main
)
where

import Control.Concurrent
import Graphics.UI.Threepenny
import qualified Graphics.UI.Threepenny as G

main :: IO ()
main = do
    t <- forkIO $ startGUI conf setup
    _ <- getLine
    killThread t
    where
        conf = defaultConfig
            {
                tpPort = Just 10000
            }
        setup window = do
            return window # set title "Indonesia long-term stock market research assistant"
            j <- h1 #+
                [
                    a
                        # set href "http://www.idx.co.id/id-id/beranda/informasipasar/indekspasar.aspx"
                        # set text "indexes"
                    , string " "
                    , a
                        # set href "http://www.idx.co.id/id-id/beranda/informasi/bagiinvestor/indeks.aspx"
                        # set text "(explanation)"

                ]
            let indexes =
                    [
                    "LQ45"
                    , "CONSUMER", "AGRI", "MANUFACTUR"
                    , "MISC-IND", "MINING", "INFRASTRUC"
                    , "TRADE", "FINANCE", "PROPERTY", "BASIC-IND"
                    ]
                bodyChildren = element j : fmap index indexes
            getBody window #+ bodyChildren
            return ()
        index name =
            G.div
                # set style [("display", "inline-block")]
                #+
                [
                    G.div # set text name
                    , img # set src (imgurl name)
                ]
        imgurl indexName =
            "http://www.idx.co.id/Portals/0/StaticData/ChartStatic/" ++ indexName ++ "_1y.png"
