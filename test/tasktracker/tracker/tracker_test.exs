defmodule Tasktracker.TrackerTest do
  use Tasktracker.DataCase

  alias Tasktracker.Tracker

  describe "tracks" do
    alias Tasktracker.Tracker.Track

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def track_fixture(attrs \\ %{}) do
      {:ok, track} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_track()

      track
    end

    test "list_tracks/0 returns all tracks" do
      track = track_fixture()
      assert Tracker.list_tracks() == [track]
    end

    test "get_track!/1 returns the track with given id" do
      track = track_fixture()
      assert Tracker.get_track!(track.id) == track
    end

    test "create_track/1 with valid data creates a track" do
      assert {:ok, %Track{} = track} = Tracker.create_track(@valid_attrs)
    end

    test "create_track/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_track(@invalid_attrs)
    end

    test "update_track/2 with valid data updates the track" do
      track = track_fixture()
      assert {:ok, track} = Tracker.update_track(track, @update_attrs)
      assert %Track{} = track
    end

    test "update_track/2 with invalid data returns error changeset" do
      track = track_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_track(track, @invalid_attrs)
      assert track == Tracker.get_track!(track.id)
    end

    test "delete_track/1 deletes the track" do
      track = track_fixture()
      assert {:ok, %Track{}} = Tracker.delete_track(track)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_track!(track.id) end
    end

    test "change_track/1 returns a track changeset" do
      track = track_fixture()
      assert %Ecto.Changeset{} = Tracker.change_track(track)
    end
  end
end
